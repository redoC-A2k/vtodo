using Gtk;
int main (string[] args) {
  Gtk.init(ref args);
  Vtodo_Calendar.init_today();
  Vtodo main_win = new Vtodo (); 
  //Box cal_box = Vtodo_Calendar.init_Calendar ();
  //win.add(cal_box);

  main_win.run (args);
  main_win.quit ();
  return 0;
}
