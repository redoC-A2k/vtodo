using Gtk;
namespace builder_vtodo{
  Builder builder = null; 

  Builder init_main_win(){
    builder = new Builder();
    try {
      builder.add_from_file("../ui/vtodo.glade");
    } catch (Error e) {
      print ("%s\n", e.message);
    }
    return builder;
  }

  Builder init_main_win_cal(){
    builder = new Builder();
    try {
      builder.add_from_file("../ui/vtodo_cal_box.glade");
    } catch (Error e) {
      print ("%s\n", e.message);
    }
    return builder;
  }
}
