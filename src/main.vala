using Gtk;
int main (string[] args) {
  Gtk.init(ref args);
  Vtodo_Calendar.init_Calendar ();
  Vtodo_Window.init().show_all ();
  Gtk.main();
  return 0;
}
