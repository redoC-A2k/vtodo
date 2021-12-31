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
    public uint8 month_no;
  }

  struct Year {
    public int name;
    public bool is_leap ;
  }

  class DateTime : GLib.DateTime{
    public DateTime (TimeZone tz, int year, int month, int day, int hour, int minute, double seconds) {
      base(tz,  year,  month,  day,  hour,  minute,  seconds);
    }
    
    public DateTime.now_local(){
      base.now_local();
    }

    public DateTime.local(int year, int month, int day, int hour, int minute, double seconds){
      base.local(year , month , day , hour , minute , seconds);
    }

    public int get_day_of_week(){
      int day = (int)base.get_day_of_week();
      if(day == 7){
        return 0;
      }
      else return day;
    }
  }

  const Month[] Months = {{"January", 31, 1},{"February", 28, 2},{"March", 31, 3},{"April", 30, 4},{"May" , 31, 5},{"June" , 30, 6},{"July" , 31, 7},{"August" , 31 , 8},{"September" , 30 , 9},{"October" , 31 , 10},{"November" , 30 , 11},{"December" , 31, 12}};
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
    if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)){
      is_leap = true;
      Months_selected[1].days = 29;
      if (month_selected.month_no == 2){
        month_selected.days = 29;
      }
    }
    return is_leap;
  }

  public void init_today(){
    today_datetime = new DateTime.now_local();
    today = {today_datetime.get_day_of_month(),today_datetime.get_month(),today_datetime.get_year(),today_datetime.get_day_of_week(),today_datetime.format("%B"),today_datetime.format("%A"),today_datetime.format("%G")}; 
    selected_day = {today_datetime.get_day_of_month(),today_datetime.get_month(),today_datetime.get_year(),today_datetime.get_day_of_week(),today_datetime.format("%B"),today_datetime.format("%A"),today_datetime.format("%G")}; 
    copy_Months();
    bool is_leap = year_is_leap(today.year_no);
    year_selected = {today.year_no,is_leap};
    month_selected = Months[int.parse(today_datetime.format("%m")) - 1];
    //print("%d-%d-%d : %d in words it is  %s %s", today.date_no,today.month_no,today.year_no,today.week_no,today.month_str,today.week_str);
    //print("\n%s and days are %d",Months[1].name,Months[1].days);
  }
  
  Box init_Calendar_grid(){
    Builder builder_scroll = builder_vtodo.init_main_scroll_months();
    Box grid_cal_container = builder_scroll.get_object("grid_cal_container") as Box;
    Grid calendar_month_grid = builder_scroll.get_object("calendar_month_grid") as Grid;
    year_selected.is_leap = year_is_leap(year_selected.name);

    DateTime first_day = new DateTime.local(year_selected.name,month_selected.month_no,1,00,00,00);
    int day_no = 1;
    for(int row = 0 ; row < 6 ; row ++){
      for(int col = 0 ; col < 7 ; col ++){
        if(row == 0 && col < first_day.get_day_of_week()){
          calendar_month_grid.add(new Label(""));
        }
        else if(day_no <= month_selected.days){
          Box day_box = new Box(Orientation.VERTICAL, 0);
          Label lbl = new Label(day_no.to_string());
          day_box.pack_start(lbl,true,true,0);
          day_box.vexpand = true;
          calendar_month_grid.attach(day_box,col,row,1,1);
          day_no++;
        }
        else{
          calendar_month_grid.attach(new Label(""),col,row,1,1);
        }
        //print("%d-%d-%d : %d in words it is  %s %s", today.date_no,today.month_no,today.year_no,today.week_no,today.month_str,today.week_str);
        //print("\n%s and days are %d",Months[1].name,Months[1].days);
      }
    }
    grid_cal_container.pack_start(calendar_month_grid);
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
        return true;
      });
      month_btn_box.pack_start(evnt_bx, true, true, 0); }
    view_scroll.add(month_btn_box);

    return scroll_months_win;
  }
  
  int[] generate_years_before_arr(int year){
    year--;
    int[] years_before = new int[10] ;
    for(int i = 9 ; i >=0 ; i--){
      years_before[i] = year;
      year--;
    }
    return years_before;
  }

  int[] generate_years_after_arr(int year){
    year++;
    int[] years_after = new int[10] ;
    for(int i=0 ; i<10 ; i++){
      years_after[i] = year;
      year++;
    }
    return years_after;
  }

  ScrolledWindow scroll_win_years_container(){
    int current_year = year_selected.name; 
    int[] years_before = generate_years_before_arr(current_year);
    int[] years_after = generate_years_after_arr(current_year);

    Array<int> years_arr = new Array<int> ();

    Builder builder_scroll = builder_vtodo.init_main_scroll_months();
    ScrolledWindow scroll_years_win = builder_scroll.get_object("scroll_months_win") as ScrolledWindow;
    Viewport view_scroll = builder_scroll.get_object("view_scroll") as Viewport;
    ButtonBox year_btn_box = builder_scroll.get_object("month_year_btn_box") as ButtonBox;

    Button go_up_btn = builder_scroll.get_object("go_up_btn") as Button;
    Button go_down_btn = builder_scroll.get_object("go_down_btn") as Button;

    years_arr.prepend_vals(years_before, 10);
    years_arr.append_val(current_year);
    years_arr.append_vals(years_after, 10);

    for (var i = 0; i < 21; i++) {
      int item = years_arr.index(i);
      EventBox evnt_bx = new EventBox();
      Label lbl = new Label(item.to_string());
      if(item==year_selected.name){
        lbl.set_name("current_year");
      }
      evnt_bx.add(lbl);
      evnt_bx.set_name("evnt_bx_"+item.to_string());

      evnt_bx.button_press_event.connect((t,a)=>{
        year_selected.name = int.parse(evnt_bx.get_name()[8:]);
        Vtodo.close_years_scroll_win();
        return true;
      });
      year_btn_box.add(evnt_bx); 
    }
    year_btn_box.add(go_down_btn);
    year_btn_box.pack_start(go_up_btn);
    year_btn_box.child_set_property(go_up_btn,"position",0);

    go_up_btn.clicked.connect(()=>{
      years_before = generate_years_before_arr(years_before[0]) ;
      for(int i = 9; i>=0 ; i--){
        EventBox evnt_bx = new EventBox();
        Label lbl = new Label(years_before[i].to_string());
        evnt_bx.add(lbl);
        year_btn_box.pack_start(evnt_bx);
        year_btn_box.child_set_property(evnt_bx,"position",1);
        evnt_bx.show_all();
      }
    });

    go_down_btn.clicked.connect(()=>{
      years_after = generate_years_after_arr(years_after[9]) ;
      for(int i = 0; i<10 ; i++){
        EventBox evnt_bx = new EventBox();
        Label lbl = new Label(years_after[i].to_string());
        evnt_bx.add(lbl);
        year_btn_box.pack_start(evnt_bx);
        evnt_bx.show_all();
      }
      year_btn_box.remove(go_down_btn);
      year_btn_box.add(go_down_btn);
      go_down_btn.show_all();
    });

    view_scroll.add(year_btn_box);
    return scroll_years_win;
  }

}
