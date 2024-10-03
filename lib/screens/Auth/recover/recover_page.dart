import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recover_controller.dart';

class RecoverPage extends StatelessWidget {
  RecoverController control = Get.put(RecoverController());

  @override
  Widget build(BuildContext context) {
    final bool isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Color(0xFF283B71), // Color de fondo de la pantalla
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Contenedor con el logo en forma cuadrangular
                Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // Bordes más sutiles
                  ),
                  child: Image.asset(
                    'assets/images/logo.png', // Asegúrate de tener el logo en esta ruta
                    width: 90,
                    height: 90,
                  ),
                ),
                SizedBox(height: 20),
                // Texto Recuperar Contraseña
                Text(
                  'Recuperar Contraseña',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Campo de correo con borde redondeado
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: control.emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Correo',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // Borde redondeado
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Botón Continuar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        control.resetPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                          color: Color(0xFF283B71),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Botón Registrarse
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => control.goToSignIn(context), // Llamada a goToSignIn
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
                SizedBox(height: 20),
                // Texto para Ingresar (Iniciar sesión)
                GestureDetector(
                  onTap: () => control.goToLogin(context), // Llamada a goToLogin
                  child: Text(
                    '¿Ya tienes una cuenta? Ingresar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Mensaje con estado de la operación
                Obx(() => control.message.isNotEmpty
                    ? Text(
                        control.message.value,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: control.messageColor.value,
                        ),
                      )
                    : SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
