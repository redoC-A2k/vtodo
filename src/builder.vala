using Gtk;
namespace builder_vtodo{
  Builder init_builder(){
    Builder builder = new Builder();
    try {
      builder.add_from_file("../ui/vtodo.glade");
    } catch (Error e) {
      print ("%s\n", e.message);
    }
    return builder;
  }
}
