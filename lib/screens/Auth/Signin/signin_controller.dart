import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/screens/Auth/Login/login_page.dart';
import 'package:psicoapp/services/user_service.dart';
import 'package:psicoapp/services/especialista_service.dart';

class SignInController extends GetxController {
  // Controladores para los campos del formulario
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController numeroCelularController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController especialidadController = TextEditingController(); // Controlador para la especialidad
  Rx<DateTime?> fechaNacimiento = Rx<DateTime?>(null);  // Fecha de nacimiento

  RxString message = ''.obs;  // Mensaje para mostrar en la UI
  var messageColor = Colors.white.obs;  // Color del mensaje
  RxBool termsCheck = false.obs;  // Estado del checkbox de términos y condiciones
  RxBool showEspecialidadField = false.obs;  // Mostrar/ocultar el campo de especialidad
  RxString markdownData = ''.obs;  // Datos del markdown para términos y condiciones

  UserService userService = UserService();  // Servicio para gestionar usuarios
  EspecialistaService especialistaService = EspecialistaService();  // Servicio para gestionar especialistas

  // Verificar si el correo contiene el dominio @validamente.cpi.com
  void checkCorreoForEspecialidad() {
    if (correoController.text.endsWith('@validamente.cpi.com')) {
      showEspecialidadField.value = true;
    } else {
      showEspecialidadField.value = false;
    }
  }

  // Método para crear una cuenta nueva
  void createAccount(BuildContext context) async {
    String rol = showEspecialidadField.value ? 'Psicologo' : 'Paciente';

    // Crear usuario en el backend
    Usuario? userCreated = await userService.register(
      nombreController.text,
      apellidoController.text,
      correoController.text,
      dniController.text,
      numeroCelularController.text,
      passwordController.text,
      fechaNacimiento.value!,
      rol,
      especialidad: showEspecialidadField.value ? especialidadController.text : null,  // Enviar especialidad solo si es psicólogo
    );

    // Mostrar error si la especialidad está vacía pero el rol es Psicologo
    if (rol == 'Psicologo' && (especialidadController.text.trim().isEmpty || userCreated == null)) {
      message.value = 'La especialidad es requerida para psicólogos';
      messageColor.value = Colors.red;
      return;
    }

    if (userCreated != null) {
      // Redirige a la página de login si todo fue bien
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      message.value = 'Error al crear la cuenta';
      messageColor.value = Colors.red;
    }
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

  // Obtener términos y condiciones desde un archivo Markdown
  Future<void> getTerms() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/mukeshsolanki/MarkdownView-Android/main/README.md')); // Ruta de ejemplo, debes cambiarla por la que necesites
    if (response.statusCode == 200) {
      markdownData.value = response.body; // Asignar el contenido Markdown al observable
    } else {
      markdownData.value = 'Error al cargar términos y condiciones';
    }
  }

  // Aceptar los términos y condiciones
  void acceptTerms() {
    termsCheck.value = true;
  }
}
