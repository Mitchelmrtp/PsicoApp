import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signin_controller.dart';

class SignInPage extends StatelessWidget {
  final SignInController control = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    control.getTerms();
    return Scaffold(
      backgroundColor: Color.fromRGBO(53, 68, 122, 1), 
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
                _buildTermsAndConditions(context),
                SizedBox(height: 30),
                _buildRegisterButton(context), 
                SizedBox(height: 20),

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
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      width: 325,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(48), 
      ),
      child: Column(
        children: [
          _buildTextField("Nombre", control.nombreController),
          _buildTextField("Apellido", control.apellidoController),
          _buildTextField("Correo", control.correoController),
          _buildTextField("DNI", control.dniController),
          _buildTextField("Número de celular", control.numeroCelularController),
          _buildTextField("Contraseña", control.passwordController),
          _buildDateField(context), 
         
          Obx(() => Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButton<String>(
              value: control.selectedRole.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  control.changeRole(newValue);
                }
              },
              items: <String>['Paciente', 'Psicólogo']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
              underline: Container(
                height: 2,
                color: const Color.fromRGBO(53, 68, 122, 1),
              ),
            ),
          )),
         
          Obx(() {
            return control.showEspecialidadField.value
                ? _buildTextField("Especialidad", control.especialidadController)
                : SizedBox.shrink();
          }),

        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 250, 
        child: TextField(
          controller: controller,
          onChanged: onChanged, 
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey), 
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromRGBO(53, 68, 122, 1), width: 2), 
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromRGBO(252, 201, 180, 1), width: 3),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          ),
          style: TextStyle(color: Colors.black), 
        ),
      ),
    );
  }

  // Widget para seleccionar la fecha de nacimiento
  Widget _buildDateField(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => control.selectDate(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 250,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Fecha de Nacimiento',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color.fromRGBO(53, 68, 122, 1), width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color.fromRGBO(252, 201, 180, 1), width: 3),
              ),
            ),
            child: Text(
              control.fechaNacimiento.value != null
                  ? "${control.fechaNacimiento.value!.toLocal()}".split(' ')[0]
                  : "Seleccionar Fecha",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    ));
  }

  // Widget para construir los términos y condiciones
  Widget _buildTermsAndConditions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Obx(() => GestureDetector(
              onTap: () {
                control.termsCheck.value = !control.termsCheck.value;
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, 
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
                            color: Color(0xFFFFCC9B4),
                          ),
                        )
                      : null,
                ),
              ),
            )),
            SizedBox(width: 10), 
            GestureDetector(
              onTap: () {
                _showBottomSheet(context);
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
      width: 200,
      height: 50, 
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
            fontSize: 18, 
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
    ));
  }
}
