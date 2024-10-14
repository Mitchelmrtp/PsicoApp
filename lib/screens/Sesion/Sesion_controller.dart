import 'package:get/get.dart';
import 'package:psicoapp/models/sesion.dart';
import 'package:psicoapp/services/sesion_service.dart';

class SesionController extends GetxController {
  final SesionService sesionService = SesionService();
  var isLoading = false.obs;

  // Crear una nueva sesión y enviarla al backend
  Future<void> createSesion({
    required int pacienteId,
    required int psicologoId,
    required String reporteProgreso,
    required String reporteEmociones,
  }) async {
    isLoading.value = true;

    try {
      // Obtener fecha y hora actual
      DateTime now = DateTime.now();
      String fecha = now.toIso8601String().split('T')[0]; // Solo la fecha
      String hora = "${now.hour}:${now.minute}"; // Hora actual

      // Crear una nueva sesión
      Sesion nuevaSesion = Sesion(
        idSesion: 0,  // Será generado por el backend
        fecha: fecha,
        hora: hora,
        reporteProgreso: reporteProgreso,
        reporteEmociones: reporteEmociones,
        pacienteId: pacienteId,
        psicologoId: psicologoId,
      );

      await sesionService.createSesion(nuevaSesion);
      Get.snackbar('Éxito', 'Sesión creada correctamente');
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al crear la sesión');
    } finally {
      isLoading.value = false;
    }
  }
}
