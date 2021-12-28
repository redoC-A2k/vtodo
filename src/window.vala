using Gtk;
class  Vtodo:Gtk.Application{
  public Vtodo(){
    Object(
      application_id:"com.redoC-a2k.github.com",
      flags:ApplicationFlags.FLAGS_NONE
    );
  }
  
  public static Builder cal_box_builder = builder_vtodo.init_main_win_cal();
  public static Box calendar_main_box = cal_box_builder.get_object("calendar_main_box") as Box ;
  public static Box cal_box = Vtodo_Calendar.init_Calendar_grid();
  public static Box win_box = new Box(Orientation.VERTICAL, 0);  
  public static bool is_month_win_open = false;
  public static bool is_year_win_open = false;
  public static ScrolledWindow scroll_months_win =  Vtodo_Calendar.scroll_win_months_container();
  public static ScrolledWindow scroll_years_win =  Vtodo_Calendar.scroll_win_years_container();
  public static Button year_btn = cal_box_builder.get_object("year_btn") as Button;
  public static Button month_btn = cal_box_builder.get_object("month_btn") as Button;

  public static void close_months_scroll_win(){
    calendar_main_box.remove(scroll_months_win);
    calendar_main_box.add(cal_box);
    cal_box.show_all();
    month_btn.label = Vtodo_Calendar.month_selected.name;
    is_month_win_open = false;
  }

  public static void open_months_scroll_win(){
    calendar_main_box.remove(cal_box);
    calendar_main_box.remove(scroll_years_win);
    calendar_main_box.pack_start(scroll_months_win);
    scroll_months_win.show_all();
    is_month_win_open = true;
    is_year_win_open = false;
    year_btn.label = Vtodo_Calendar.year_selected.name.to_string();
    month_btn.label = "Back";
  }

  public static void close_years_scroll_win(){
    calendar_main_box.remove(scroll_years_win);
    calendar_main_box.add(cal_box);
    cal_box.show_all();
    year_btn.label = Vtodo_Calendar.year_selected.name.to_string();
    is_year_win_open = false;
  }

  public static void open_years_scroll_win(){
    calendar_main_box.remove(cal_box);
    calendar_main_box.remove(scroll_months_win);
    calendar_main_box.pack_start(scroll_years_win);
    scroll_years_win.show_all();
    is_year_win_open = true;
    is_month_win_open = false;
    month_btn.label = Vtodo_Calendar.month_selected.name;
    year_btn.label = "Back";
  }

  construct{
    win_box.spacing = 0;
    win_box.homogeneous = false;
    win_box.set_valign(Align.START);
    win_box.set_vexpand(true);


    Box main_title_box = cal_box_builder.get_object("main_title_box") as Box;
    win_box.pack_start(main_title_box,true,true,0);

    calendar_main_box.pack_start(cal_box,true,true,0);
    win_box.pack_start(calendar_main_box,true,true,0);

    //setting up month button
    month_btn.label = Vtodo_Calendar.month_selected.name.to_string();

    month_btn.clicked.connect(()=>{
      if (is_month_win_open == false)
        open_months_scroll_win();
      else
        close_months_scroll_win();
    });


    //setting up year button
    year_btn.label = Vtodo_Calendar.year_selected.name.to_string();

    year_btn.clicked.connect(()=>{
      if (is_year_win_open == false)
        open_years_scroll_win();
      else
        close_years_scroll_win(); 
    });
  }

  protected override void activate(){
      // setting up window
    ApplicationWindow window =  new ApplicationWindow(this);
    window.title = "VTodo"; 
    window.set_default_size(700, 500);

    window.add(win_box);
      //setting up css 
    try {
      var css_provider = new CssProvider ();
      css_provider.load_from_path ("../ui/styles/index.css");
      Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(),css_provider,Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION); 
    } catch (Error e) {
      print ("%s\n", e.message);
    }

    window.show_all();
  }
}

