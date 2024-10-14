import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recover_controller.dart';

class RecoverPage extends StatelessWidget {
  final RecoverController control = Get.put(RecoverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(53, 68, 122, 1),  // Fondo azul
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                _buildForm(),
                SizedBox(height: 30),
                _buildRecoverButton(context),
                SizedBox(height: 20),
                Obx(() => Text(
                      control.message.value,
                      style: TextStyle(
                        fontSize: 18,
                        color: control.messageColor.value,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(
          'assets/images/logo.png',  // Cambiar según tu ruta de imagen
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: 325,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        children: [
          _buildTextField('Correo', control.emailController),
          _buildTextField('DNI', control.dniController),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 250,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromRGBO(53, 68, 122, 1), width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromRGBO(252, 201, 180, 1), width: 3),
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildRecoverButton(BuildContext context) {
  return Container(
    width: 300,
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 40),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => control.recoverPassword(context),  // Llama al método con el contexto
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF3E4A67),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: Text(
          'Recuperar contraseña',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}}
