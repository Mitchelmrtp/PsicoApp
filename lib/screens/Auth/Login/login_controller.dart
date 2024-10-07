import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/screens/Auth/Recover/recover_page.dart';
import 'package:ulimagym/screens/Auth/Signin/signin_page.dart';
import 'package:ulimagym/screens/Home/Home_Paciente/homepaciente_page.dart';
import 'package:ulimagym/models/entities/Usuario.dart';
import 'package:ulimagym/screens/Home/Home_Psicologo/homepsicologo_page.dart';
import 'package:ulimagym/services/user_service.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = 'primer mensaje'.obs;
  var messageColor = Colors.white.obs;
  UserService userService = UserService();

void login(BuildContext context) async {
  String user = userController.text;
  String password = passController.text;

  // Obtener el usuario autenticado desde el servicio de usuario
  Usuario? userValidated = await userService.validate(user, password);

  if (userValidated == null) {
    message.value = 'Error en el servidor';
    messageColor.value = Colors.red;
  } else if (userValidated.id == 0) {
    message.value = 'Usuario o contraseña incorrectos';
    messageColor.value = Colors.red;
  } else {
    // Redirigir dependiendo del rol del usuario
    if (userValidated.rol == 'Psicologo') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePsicologoPage(usuarioLogged: userValidated),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePacientePage(usuarioLogged: userValidated),
        ),
      );
    }
  }
}




  // Redirigir al registro
  void goToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  // Redirigir a la recuperación de contraseña
  void goToRecover(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecoverPage()),
    );
  }
}
