using Gtk;
namespace Vtodo_Calendar {

  struct Day {
    public int date_no;
    public int month_no; 
    public int year_no;
    public int week_no;
    public string month_str;
    public string week_str;
  }
  
  DateTime today_datetime;
  Day today;

  void init_today(){
    today_datetime = new DateTime.now_local();
    today = {today_datetime.get_day_of_month(),today_datetime.get_month(),today_datetime.get_year(),today_datetime.get_day_of_week(),today_datetime.format("%B"),today_datetime.format("%A")}; 
    //print("%d-%d-%d : %d in words it is  %s %s", today.date_no,today.month_no,today.year_no,today.week_no,today.month_str,today.week_str);
  }

  void init_Calendar(){
    init_today();
  
    Builder builder_glade = builder_vtodo.init_builder();
    
    //setting up month button
    Button month_button = builder_glade.get_object("month_button") as Button;
    stdout.printf("%s",month_button.label);
    month_button.label=today.month_str;
    stdout.printf("%s",month_button.label);

    //setting up year button
    Button year_button = builder_glade.get_object("year_button") as Button;
    //year_button.set_label((string)today.year_no);
  }
}

