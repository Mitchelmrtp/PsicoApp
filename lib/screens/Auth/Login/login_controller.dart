import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/entities/Usuario.dart';
import '../../../services/user_service.dart';
import '../Signin/signin_page.dart';
import '../Recover/recover_page.dart';
import '../../home/home_page.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = ''.obs;
  var messageColor = Colors.white.obs;
  UserService userService = UserService();

  // Método para manejar el inicio de sesión
  void login(BuildContext context) async {
  print('Iniciando sesión desde el controlador');
  String user = userController.text;
  String password = passController.text;

  Usuario? userValidated = await userService.validate(user, password);

  if (userValidated == null) {
    message.value = 'Error en el servidor';
    messageColor.value = Colors.red;
  } else if (userValidated.id == 0) {
    message.value = 'Usuario o contraseña incorrectos';
    messageColor.value = Colors.red;
  } else {
    print('Usuario autenticado correctamente');
    message.value = 'Usuario autenticado correctamente';
    messageColor.value = Colors.green;

    // Redirigir a la página principal (HomePage)
    Future.delayed(Duration(seconds: 0), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  usuarioLogged: userValidated,
                )),
      );
    });
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
