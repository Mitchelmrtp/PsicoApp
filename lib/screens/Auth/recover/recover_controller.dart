import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/services/user_service.dart';

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

  // Llama al servicio para recuperar la contraseña
  String? contrasena = await userService.recuperarContrasena(dni, email);

  if (contrasena != null) {
    message.value = "Tu contraseña es: $contrasena";  // Mostrar la contraseña en la UI
    messageColor.value = Colors.green;
  } else {
    message.value = "No se pudo encontrar la contraseña con los datos proporcionados";
    messageColor.value = Colors.red;
  }
}





// Función para mostrar el diálogo con la contraseña recuperada
void _showPasswordDialog(BuildContext context, String password) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Contraseña Recuperada'),
        content: Text('La contraseña es: $password'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
          ),
        ],
      );
    },
  );
}}