import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController control = Get.put(LoginController());

  Widget _form(BuildContext context) {
    return SingleChildScrollView( // Permite desplazarse si el contenido es demasiado grande
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Logo container
          Container(
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
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 40),
          // Input container
          Container(
            width: 290,
            height: 165,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(48),
            ),
            child: Column(
              children: [
                // Campo de texto para el usuario con un underline más corto
                Container(
                  width: 210, // Ajusta el ancho deseado del underline
                  child: TextField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromRGBO(53, 68, 122, 1),
                          width: 2.0, // Grosor de la línea cuando el TextField no está enfocado
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromRGBO(252, 201, 180, 1),
                          width: 3.0, // Grosor de la línea cuando el TextField está enfocado
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        bottom: -10, // Acerca el labelText al underline
                        left: 0,
                        right: 0,
                      ),
                    ),
                    controller: control.userController,
                  ),
                ),
                SizedBox(height: 10),
                // Campo de texto para la contraseña con un underline más corto
                Container(
                  width: 210, // Ajusta el ancho deseado del underline
                  child: TextField(
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromRGBO(53, 68, 122, 1),
                          width: 2.0, // Grosor de la línea cuando el TextField no está enfocado
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromRGBO(252, 201, 180, 1),
                          width: 3.0, // Grosor de la línea cuando el TextField está enfocado
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        bottom: -10, // Acerca el labelText al underline
                        left: 0,
                        right: 0,
                      ),
                    ),
                    controller: control.passController,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Login button
          Container(
             width: 300,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => control.login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF3E4A67),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Register button
          Container(
            width: 300,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => control.goToSignIn(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                child: Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          // Forgot password link
          GestureDetector(
            onTap: () => control.goToRecover(context),
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Container(
      color: Color.fromRGBO(53, 68, 122, 1),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        Center(child: _form(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
