import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signin_controller.dart';

class SignInPage extends StatelessWidget {
  final SignInController control = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    control.getTerms();  // Cargar los términos y condiciones
    return Scaffold(
      backgroundColor: Color.fromRGBO(53, 68, 122, 1),  // Color de fondo azul
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                _buildForm(context),
                SizedBox(height: 30),
                _buildTermsAndConditions(context), // Términos y condiciones
                SizedBox(height: 30),
                _buildRegisterButton(context),  // Botón para registrarse
                SizedBox(height: 20),
                // Mensaje en caso de éxito o error
                Obx(() => Text(
                      control.message.value,
                      style: TextStyle(
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

  // Widget para construir el logo
  Widget _buildLogo() {
    return Column(
      children: [
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
              'assets/images/logo.png',  // Cambia esto según la ruta de tu logo
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Widget para construir el formulario de registro
  Widget _buildForm(BuildContext context) {
    return Container(
      width: 325,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,  // Color de fondo del formulario
        borderRadius: BorderRadius.circular(48),  // Bordes redondeados
      ),
      child: Column(
        children: [
          _buildTextField("Nombre(s)", control.nombreController),
          _buildTextField("Correo", control.correoController),
          _buildTextField("DNI", control.dniController),
          _buildTextField("Tipo de usuario", control.tipoUsuarioController),
          _buildTextField("Número de celular", control.numeroCelularController),
          _buildTextField("Contraseña", control.passwordController),
        ],
      ),
    );
  }

  // Widget para construir los campos de texto
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 250,  // Controlamos el ancho del input
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey),  // Color del texto de la etiqueta
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromRGBO(53, 68, 122, 1), width: 2),  // Color de la línea cuando no está enfocado
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromRGBO(252, 201, 180, 1), width: 3),  // Color de la línea al enfocar
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),  // Reducir el padding vertical
          ),
          style: TextStyle(color: Colors.black),  // Color del texto de entrada
        ),
      ),
    );
  }

  // Widget para construir los términos y condiciones
  Widget _buildTermsAndConditions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,  // Alineación del checkbox
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,  // Alinear checkbox y texto en el centro
          children: [
            // Checkbox personalizado
            Obx(() => GestureDetector(
                  onTap: () {
                    // Cambiar el valor del checkbox
                    control.termsCheck.value = !control.termsCheck.value;
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,  // Color del borde del checkbox
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: control.termsCheck.value
                          ? Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFCC9B4),  // Color interno del círculo al presionar
                              ),
                            )
                          : null,  // No mostrar nada si no está presionado
                    ),
                  ),
                )),
            SizedBox(width: 10),  // Espacio entre el checkbox y el texto
            GestureDetector(
              onTap: () {
                _showBottomSheet(context);  // Mostrar los términos y condiciones
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Acepto los ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: "Términos y condiciones",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Mostrar los términos y condiciones en un BottomSheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Términos y Condiciones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(control.markdownData.value),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        control.acceptTerms();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2196F3),
                      ),
                      child: Text('Acepto'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2196F3),
                      ),
                      child: Text('No acepto'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // Widget para construir el botón de "Registrarse"
  Widget _buildRegisterButton(BuildContext context) {
    return Obx(() => SizedBox(
          width: 200,  // Ancho del botón
          height: 50,  // Altura del botón
          child: ElevatedButton(
            onPressed: control.termsCheck.value
                ? () => control.createAccount(context)
                : null,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48),
                side: BorderSide(color: Colors.lightBlueAccent, width: 2),
              ),
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              "Registrarse",
              style: TextStyle(
                fontSize: 18,  // Tamaño de la fuente
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
        ));
  }
}
