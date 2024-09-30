import 'package:get/get.dart';

/// Modelo para los ítems de la cuadrícula en la pantalla de inicio.
class TipsgridItemModel {
  Rx<String> image;
  Rx<String> id;

  TipsgridItemModel({required String image, String id = ""})
      : this.image = image.obs,
        this.id = id.obs;
}
