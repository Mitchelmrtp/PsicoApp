import 'package:get/get.dart';
import 'package:ulimagym/pages/pantalla_inicio/models/inicio_initial.dart';
import 'package:ulimagym/pages/pantalla_inicio/models/inicio_model.dart';

/// Controlador para manejar el estado de la pantalla de inicio.
class PantallaDeInicioController extends GetxController {
  Rx<PantallaDeInicioModel> pantallaDeInicioModelObj = PantallaDeInicioModel().obs;
  Rx<PantallaDeInicioInicialModel> pantallaDeInicioInicialModelObj = PantallaDeInicioInicialModel().obs;
}
