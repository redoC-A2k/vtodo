using Gtk;
namespace Vtodo_Calendar {

  struct Day {
    public int date_no;
    public int month_no; 
    public int year_no;
    public int week_no;
    public string month_str;
    public string week_str;
    public string year_str;
  }
  
  struct Month {
    public string name;
    public uint8 days;
  }

  struct Year {
    public int name;
    public bool is_leap ;
  }

  const Month[] Months = {{"January",31},{"February",28},{"March",31},{"April",30},{"May" , 31},{"June" , 30},{"July" , 31},{"August" , 31},{"September" , 30},{"October" , 31},{"November" , 30},{"December" , 31}};
  Month[] Months_selected ;
  
  DateTime today_datetime;
  Month month_selected;
  Year year_selected;
  Day selected_day ;
  Day today;

  void copy_Months(){
    Months_selected = new Month[12];
    for (var i = 0; i < 12; i++) 
      Months_selected[i] = Months[i];
  }

  bool year_is_leap(int year){
    bool is_leap=false;
    if((today.year_no % 4 == 0) && ((today.year_no % 400 == 0) || (today.year_no % 100 != 0))){
      is_leap = true;
      Months_selected[1].days = 29;
    }
    return is_leap;
  }

  void init_today(){
    today_datetime = new DateTime.now_local();
    today = {today_datetime.get_day_of_month(),today_datetime.get_month(),today_datetime.get_year(),today_datetime.get_day_of_week(),today_datetime.format("%B"),today_datetime.format("%A"),today_datetime.format("%G")}; 
    copy_Months();
    bool is_leap = year_is_leap(today.year_no);
    year_selected = {today.year_no,is_leap};
    month_selected = Months[int.parse(today_datetime.format("%m")) - 1];
    //print("%d-%d-%d : %d in words it is  %s %s", today.date_no,today.month_no,today.year_no,today.week_no,today.month_str,today.week_str);
    //print("\n%s and days are %d",Months[1].name,Months[1].days);
  }
  
  Box init_Calendar_grid(){
    init_today();
    Builder builder_scroll = builder_vtodo.init_main_scroll_months();
    Box grid_cal_container = builder_scroll.get_object("grid_cal_container") as Box;
    return grid_cal_container;
  }

  ScrolledWindow scroll_win_months_container(){
    Builder builder_scroll = builder_vtodo.init_main_scroll_months();
    ScrolledWindow scroll_months_win = builder_scroll.get_object("scroll_months_win") as ScrolledWindow;
    Viewport view_scroll = builder_scroll.get_object("view_scroll") as Viewport;
    ButtonBox month_btn_box = builder_scroll.get_object("month_year_btn_box") as ButtonBox;

    for (int i = 0; i < 12  ; i++) {
      EventBox evnt_bx = new EventBox();
      evnt_bx.add(new Label((string)(Months[i].name)));
      evnt_bx.set_name("evnt_bx_"+i.to_string());
      evnt_bx.button_press_event.connect((t,a)=>{
        month_selected = Months_selected[int.parse(evnt_bx.get_name()[8:])];
        Vtodo.close_months_scroll_win();
        //Vtodo.is_month_win_open = false;
        return true;
      });
      month_btn_box.pack_start(evnt_bx, true, true, 0); }
    view_scroll.add(month_btn_box);

    return scroll_months_win;
  }
  
  int[] generate_years_before_arr(int year){
    year--;
    int[] years_before = new int[20] ;
    for(int i = 19 ; i >=0 ; i--){
      years_before[i] = year;
      year--;
    }
    return years_before;
  }

  ScrolledWindow scroll_win_years_container(){
    int current_year = year_selected.name; 
    int[] years_before = generate_years_before_arr(current_year);

    Builder builder_scroll = builder_vtodo.init_main_scroll_months();
    //ScrolledWindow scroll_years_win = builder_scroll.get_object("scroll_months_win") as ScrolledWindow;
    //Viewport view_scroll = builder_scroll.get_object("view_scroll") as Viewport;
    ButtonBox year_btn_box = builder_scroll.get_object("month_year_btn_box") as ButtonBox;
    Adjustment adjv = new Adjustment(72.00, 0.00, 100.00, 1.00, 10.00, 0.00);
    Adjustment adjh = new Adjustment(0.00, 0.00, 100.00, 1.00, 10.00, 0.00);
    ScrolledWindow scroll_years_win = new ScrolledWindow(adjh, adjv);
    Viewport view_scroll = new Viewport(adjh,adjv);

    foreach (int item in years_before) {
      EventBox evnt_bx = new EventBox();
      evnt_bx.add(new Label(item.to_string()));
      evnt_bx.set_name("evnt_bx_"+item.to_string());

      evnt_bx.button_press_event.connect((t,a)=>{
        year_selected.name = int.parse(evnt_bx.get_name()[8:]);
        year_selected.is_leap = year_is_leap(year_selected.name);
        //print(year_selected.name.to_string());
        Vtodo.close_years_scroll_win();
        //Vtodo.is_month_win_open = false;
        return true;
      });

      year_btn_box.add(evnt_bx); 
    }
    view_scroll.add(year_btn_box);
    Adjustment adj = scroll_years_win.vadjustment;
    adj.value = 87.00;
    //adj.value = 118.00;
    view_scroll.set_vadjustment(adjv);
    scroll_years_win.add(view_scroll);
    scroll_years_win.propagate_natural_height = true;
    //adj.set_value(adj.get_upper());
    return scroll_years_win;
  }
}
