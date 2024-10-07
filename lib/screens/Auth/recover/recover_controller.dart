import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/services/user_service.dart';

class RecoverController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController dniController = TextEditingController();

  RxString message = ''.obs;
  var messageColor = Colors.white.obs;
  UserService userService = UserService();

  // Método para enviar solicitud de recuperación de contraseña
  void recoverPassword(BuildContext context) async {
    String email = emailController.text;
    String dni = dniController.text;

    String? result = await userService.reset(dni, email);

    if (result == "Email enviado con éxito") {
      message.value = "Se ha enviado un correo de recuperación";
      messageColor.value = Colors.green;
    } else {
      message.value = "No se pudo enviar el correo de recuperación";
      messageColor.value = Colors.red;
    }
  }
}
