import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/user_service.dart';
import 'package:ulimagym/screens/Auth/Login/login_page.dart';
import 'package:ulimagym/screens/Auth/Signin/signin_page.dart';

class RecoverController extends GetxController {
  TextEditingController dniController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  UserService userService = UserService();
  
  // Inicializamos el mensaje vacío para que no aparezca por defecto
  RxString message = ''.obs;
  var messageColor = Colors.white.obs;

  void resetPassword() async {
    String dni = dniController.text;
    String email = emailController.text;
    String? messageServer = await userService.reset(dni, email);
    if (messageServer == null) {
      message.value = 'Ocurrió un error con el servidor';
      messageColor.value = Colors.red;
    } else {
      if (messageServer == "Contraseña actualizada") {
        message.value = 'Se le ha enviado un correo para que cambie su contraseña';
        messageColor.value = Colors.green;
      } else {
        message.value = 'Datos inválidos';
        messageColor.value = Colors.red;
      }
    }
  }

  // Navegación a la pantalla de "Registrarse"
  void goToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  // Navegación a la pantalla de "Ingresar" (Iniciar sesión)
  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
