import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/entities/doctor.dart';
import '../../../services/doctor_service.dart';

class DoctorProfileController extends GetxController {
  Rx<Doctor?> doctor = Doctor.empty().obs;  // Doctor observable
  DoctorService doctorService = DoctorService();

  // Método para obtener los datos del doctor
  void loadDoctor(int id) async {
    try {
      Doctor? fetchedDoctor = await doctorService.getDoctorById(id);
      if (fetchedDoctor != null) {
        doctor.value = fetchedDoctor;
        print('Datos del doctor cargados correctamente');
      } else {
        print('No se pudo obtener el perfil del doctor');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Método para editar el perfil del doctor (Ejemplo)
  void editDoctorProfile(BuildContext context) {
    print("Editar perfil del doctor");
    // Aquí podrías abrir una pantalla para editar el perfil
  }
}
