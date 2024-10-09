import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/services/solicitarcita_service.dart'; // Importamos el servicio de citas

class SolicitarCitaController extends GetxController {
  Usuario user = Usuario.empty();
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  RxString eventTitle = 'Reservar una Cita'.obs;
  RxBool isDayTime = true.obs;
  RxString motivo = ''.obs; // Variable to store the reason for the appointment

  // Function to change the icon depending on the time of the day
  void checkDayTime() {
    int currentHour = DateTime.now().hour;
    if (currentHour >= 6 && currentHour < 18) {
      isDayTime.value = true;
    } else {
      isDayTime.value = false;
    }
  }

  // Method to select date and time
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
        showMotivoDialog(context); // Show the dialog to input the reason for the appointment
      }
    }
  }

  // Show dialog to input the reason for the appointment
  void showMotivoDialog(BuildContext context) {
    TextEditingController motivoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el motivo de la cita'),
          content: TextField(
            controller: motivoController,
            decoration: InputDecoration(
              hintText: 'Motivo de la cita',
            ),
          ),
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
                motivo.value = motivoController.text;
                Navigator.of(context).pop();
                submitCita(); // Call the function to submit the appointment
              },
            ),
          ],
        );
      },
    );
  }

  // Function to submit the appointment to the backend
Future<void> submitCita() async {
  if (selectedDateTime.value != null && motivo.value.isNotEmpty) {
    // Obtén la fecha y hora seleccionada
    DateTime fechaHora = selectedDateTime.value!;

    // Obtén el ID del paciente automáticamente desde el usuario logueado
    int pacienteId = user.id; // Aquí el 'user' es el usuario autenticado

    // Verifica que se obtiene el id del paciente correctamente
    print("ID del paciente: $pacienteId");

    // Llama al método para crear la cita con el ID del paciente
    bool success = await CitaService().createCita(pacienteId, fechaHora, motivo.value);

    if (success) {
      Get.snackbar('Éxito', 'Cita reservada correctamente');
    } else {
      Get.snackbar('Error', 'No se pudo reservar la cita');
    }
  }
}

  // Method to reschedule the appointment
  Future<void> rescheduleCita(BuildContext context) async {
    await selectDateTime(context); // Allow the user to pick a new date and time
  }
}
