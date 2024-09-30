import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/pages/pantalla_inicio/controller/inicio_controller.dart';
import 'package:ulimagym/pages/pantalla_inicio/models/item_model.dart';


class TipsgridItemWidget extends StatelessWidget {
  final TipsgridItemModel tipsgridItemModelObj;

  TipsgridItemWidget(this.tipsgridItemModelObj);

  var controller = Get.find<PantallaDeInicioController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => Image.asset(
              tipsgridItemModelObj.image.value,
              height: 154,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Consejos para un ambiente ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "saludable",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
