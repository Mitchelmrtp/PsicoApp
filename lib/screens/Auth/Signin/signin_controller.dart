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
  TextEditingController especialidadController = TextEditingController(); 
  Rx<DateTime?> fechaNacimiento = Rx<DateTime?>(null);  

  RxString message = ''.obs;  
  var messageColor = Colors.white.obs;  
  RxBool termsCheck = false.obs;  
  RxBool showEspecialidadField = false.obs;  
  RxString markdownData = ''.obs;  
  RxString selectedRole = 'Paciente'.obs;

  UserService userService = UserService();  
  EspecialistaService especialistaService = EspecialistaService(); 

  void changeRole(String role) {
    selectedRole.value = role;
    showEspecialidadField.value = role == 'Psicólogo';
  }

  void createAccount(BuildContext context) async {
    String rol = selectedRole.value;

    Usuario? userCreated = await userService.register(
      nombreController.text,
      apellidoController.text,
      correoController.text,
      dniController.text,
      numeroCelularController.text,
      passwordController.text,
      fechaNacimiento.value!,
      rol,
      especialidad: showEspecialidadField.value ? especialidadController.text : null,  
    );

    if (rol == 'Psicologo' && (especialidadController.text.trim().isEmpty || userCreated == null)) {
      message.value = 'La especialidad es requerida para psicólogos';
      messageColor.value = Colors.red;
      return;
    }

    if (userCreated != null) {
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

  Future<void> getTerms() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/mukeshsolanki/MarkdownView-Android/main/README.md')); 
    if (response.statusCode == 200) {
      markdownData.value = response.body; 
    } else {
      markdownData.value = 'Error al cargar términos y condiciones';
    }
  }

  void acceptTerms() {
    termsCheck.value = true;
  }
}
