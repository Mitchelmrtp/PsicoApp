import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/services/solicitarcita_service.dart'; // Importamos el servicio de citas

class SolicitarCitaController extends GetxController {
  Usuario user = Usuario.empty();
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  RxString eventTitle = 'Reservar una Cita'.obs;
  RxBool isDayTime = true.obs;
  RxString motivo = ''.obs;

  // Aquí cambiamos a RxnInt para permitir valores nulos
  RxnInt citaId = RxnInt(null); 

  List<String> motivosDisponibles = ['Ansiedad', 'Depresión', 'Baja Autoestima'];
  RxString selectedMotivo = ''.obs;

  void checkDayTime() {
    int currentHour = DateTime.now().hour;
    isDayTime.value = currentHour >= 6 && currentHour < 18;
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedDateTime.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        eventTitle.value = 'Diagnóstico Psicológico - Primera Sesión';
        showMotivoDialog(context);
      }
    }
  }

  void showMotivoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccione el motivo de la cita'),
          content: Obx(() {
            return DropdownButton<String>(
              isExpanded: true,
              value: selectedMotivo.value.isEmpty ? null : selectedMotivo.value,
              hint: Text('Seleccione un motivo'),
              items: motivosDisponibles.map((String motivo) {
                return DropdownMenuItem<String>(
                  value: motivo,
                  child: Text(motivo),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedMotivo.value = newValue ?? '';
              },
            );
          }),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                motivo.value = selectedMotivo.value;
                Navigator.of(context).pop();
                if (citaId.value != null) {
                  updateCita(); // Actualiza la cita existente
                } else {
                  submitCita(); // Crea una nueva cita
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Método para crear una nueva cita
  Future<void> submitCita() async {
    if (selectedDateTime.value != null && motivo.value.isNotEmpty) {
      DateTime fechaHora = selectedDateTime.value!;
      int pacienteId = user.id;

      print({
        "pacienteId": pacienteId,
        "fechaHora": fechaHora,
        "motivo": motivo.value,
      });

      bool success = await CitaService().createCita(pacienteId, fechaHora, motivo.value);

      if (success) {
        Get.snackbar('Éxito', 'Cita reservada correctamente');
      } else {
        Get.snackbar('Error', 'No se pudo reservar la cita');
      }
    }
  }

  // Método para actualizar una cita existente
  Future<void> updateCita() async {
    if (selectedDateTime.value != null && motivo.value.isNotEmpty && citaId.value != null) {
      DateTime fechaHora = selectedDateTime.value!;
      int pacienteId = user.id;

      print({
        "citaId": citaId.value,
        "pacienteId": pacienteId,
        "fechaHora": fechaHora,
        "motivo": motivo.value,
      });

      bool success = await CitaService().updateCita(citaId.value!, pacienteId, fechaHora, motivo.value);

      if (success) {
        Get.snackbar('Éxito', 'Cita reagendada correctamente');
      } else {
        Get.snackbar('Error', 'No se pudo reagendar la cita');
      }
    }
  }

  Future<void> rescheduleCita(BuildContext context) async {
    await selectDateTime(context);
  }
}

