import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ulimagym/models/entities/Usuario.dart';
import 'package:ulimagym/screens/Auth/Login/login_page.dart';
import 'package:ulimagym/services/user_service.dart';
import 'dart:convert';

class SignInController extends GetxController {
  // Controladores para los campos del formulario
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController numeroCelularController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<DateTime?> fechaNacimiento = Rx<DateTime?>(null);  // Fecha de nacimiento controlada

  RxString message = ''.obs;  // Mensaje de éxito o error
  var messageColor = Colors.white.obs;  // Color del mensaje
  RxBool termsCheck = false.obs;  // Estado del checkbox de términos y condiciones
  RxString markdownData = ''.obs;  // Contenido de los términos y condiciones en Markdown

  UserService userService = UserService();  // Servicio de usuario para manejar la API

  // Método para crear una cuenta nueva
  void createAccount(BuildContext context) async {
    String nombre = nombreController.text;
    String apellido = apellidoController.text;
    String correo = correoController.text;
    String dni = dniController.text;
    String numeroCelular = numeroCelularController.text;
    String contrasena = passwordController.text;
    DateTime? fechaNac = fechaNacimiento.value;

    if (fechaNac == null) {
      message.value = 'Por favor selecciona una fecha de nacimiento';
      messageColor.value = Colors.red;
      return;
    }

    // Llamamos al método de registro en UserService
    Usuario? userCreated = await userService.register(
      nombre, apellido, correo, dni, numeroCelular, contrasena, fechaNac
    );

    if (userCreated != null) {
      message.value = 'Cuenta creada con éxito';
      messageColor.value = Colors.green;

      // Redirigir al login después de crear la cuenta
      Future.delayed(Duration(seconds: 0), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    } else {
      message.value = 'Error al crear la cuenta';
      messageColor.value = Colors.red;
    }
  }

  // Cargar los términos y condiciones desde un archivo Markdown
  Future<void> getTerms() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/mukeshsolanki/MarkdownView-Android/main/README.md'));  // Ruta de ejemplo, debes cambiarla por la que necesites
    if (response.statusCode == 200) {
      markdownData.value = response.body;  // Asignar el contenido Markdown al observable
    } else {
      markdownData.value = 'Error al cargar términos y condiciones';
    }
  }

  // Aceptar los términos y condiciones
  void acceptTerms() {
    termsCheck.value = true;
  }

  // Función para redirigir al login
  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Seleccionar la fecha de nacimiento
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != fechaNacimiento.value) {
      fechaNacimiento.value = picked;
    }
  }
}
