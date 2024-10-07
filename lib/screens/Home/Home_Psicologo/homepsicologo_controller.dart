import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/screens/Auth/Login/login_page.dart';

class HomePsicologoController extends GetxController {
  // Definir el método goToSignIn para redirigir a la pantalla de inicio de sesión
  void goToLogIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Redirigir a la página de inicio de sesión
      ),
    );
  }
}
