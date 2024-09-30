import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/pages/pantalla_inicio/inicio_initial_p.dart';


class PantallaDeInicioScreen extends StatelessWidget {
  const PantallaDeInicioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla de Inicio"),
        centerTitle: true,
      ),
      body: PantallaDeInicioInitialPage(),
    );
  }
}
