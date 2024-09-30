import 'package:get/get.dart';
import 'package:ulimagym/pages/pantalla_inicio/models/item_model.dart';

/// Esta clase es utilizada en la pantalla inicial para cargar los items.
class PantallaDeInicioInicialModel {
  Rx<List<TipsgridItemModel>> tipsgridItemList = Rx([
    TipsgridItemModel(image: "assets/images/medico_mujeres.png"),
    TipsgridItemModel(image: "assets/images/medicos_investi.png"),
    TipsgridItemModel(image: "assets/images/alimentos_sanos_baratos.png"),
    TipsgridItemModel(image: "assets/images/mujer_meditando_lago.png"),
  ]);
}
