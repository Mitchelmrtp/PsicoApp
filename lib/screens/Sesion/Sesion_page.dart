import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/screens/Sesion/Sesion_controller.dart';

class SesionPage extends StatelessWidget {
  final int pacienteId;  // ID del paciente seleccionado
  final int psicologoId; // ID del psicólogo logueado

  // Controladores para los reportes
  final TextEditingController progresoController = TextEditingController();
  final TextEditingController emocionesController = TextEditingController();

  SesionPage({required this.pacienteId, required this.psicologoId});

  final SesionController  sesionController = Get.put(SesionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reporte de Progreso:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: progresoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el reporte de progreso',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            Text(
              "Reporte de Emociones:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: emocionesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el reporte de emociones',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 32),
            Obx(() {
              return sesionController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        await sesionController.createSesion(
                          pacienteId: pacienteId,
                          psicologoId: psicologoId,
                          reporteProgreso: progresoController.text,
                          reporteEmociones: emocionesController.text,
                        );
                        Navigator.pop(context); // Volver a la pantalla anterior
                      },
                      child: Text('Enviar Reporte'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
