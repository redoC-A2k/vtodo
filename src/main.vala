using Gtk;
int main (string[] args) {
  Gtk.init(ref args);
  ApplicationWindow win = Vtodo_Window.init_win();
  Box cal_box = Vtodo_Calendar.init_Calendar ();
  win.add(cal_box);
  win.show_all ();
  Gtk.main();
  return 0;
}
