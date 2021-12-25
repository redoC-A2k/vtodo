using Gtk;
namespace  Vtodo_Window{
  ApplicationWindow init_win(){
    ApplicationWindow window = null;
    try {
      // setting up window
      window = builder_vtodo.init_main_win().get_object("main_window") as ApplicationWindow;
      window.destroy.connect (Gtk.main_quit);

      //setting up css 
      var css_provider = new CssProvider ();
      css_provider.load_from_path ("../ui/styles/index.css");
      Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(),css_provider,Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION); 

    } catch (Error e) {
      print("%s\n", e.message);
    }
    return window;
  }
}

/* int main (string[] args) {
  Gtk.init(ref args);
  ApplicationWindow window = Window.init();
  window.show_all();
  Gtk.main();
  return 0;
} */
