import 'package:get/get.dart';
import 'package:ulimagym/pages/pantalla_inicio/controller/inicio_controller.dart';

/// A binding class for the PantallaDeInicioScreen.
class PantallaDeInicioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PantallaDeInicioController());
  }
}
