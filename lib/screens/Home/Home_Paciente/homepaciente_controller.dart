import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/screens/Auth/Login/login_page.dart';

class HomePacienteController extends GetxController {

  void goToLogIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), 
      ),
    );
  }
}
