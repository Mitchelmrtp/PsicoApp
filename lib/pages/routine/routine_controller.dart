import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/entities/Usuario.dart';

class RoutineController extends GetxController {
  // Declaración de la variable `user`
  Usuario user = Usuario.empty();

  // Otras variables y funciones del controlador
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null); // Almacena la fecha y hora de la cita
  RxString eventTitle = 'Reservar una Cita'.obs; // Almacena el título del evento
  RxBool isDayTime = true.obs; // Determina si es de día o de noche

  // Función para cambiar el ícono según la hora del día
  void checkDayTime() {
    int currentHour = DateTime.now().hour;
    if (currentHour >= 6 && currentHour < 18) {
      isDayTime.value = true; // Es de día
    } else {
      isDayTime.value = false; // Es de noche
    }
  }

  // Función para seleccionar fecha y hora
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
        eventTitle.value = 'Diagnóstico Psicológico - Primera Sesión'; // Cambiar el título del evento
      }
    }
  }

  // Función para reagendar la cita
  void rescheduleCita(BuildContext context) {
    selectDateTime(context);
  }
}
