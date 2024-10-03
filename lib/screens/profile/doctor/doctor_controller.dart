import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/models/entities/Doctor.dart';
import 'package:ulimagym/services/doctor_service.dart';

class DoctorController extends GetxController {
  DoctorService doctorService = DoctorService();
  var doctorsList = <Doctor>[].obs;
  var doctor = Doctor(id: 0, nombre: '', especialidadId: 0, horarioId: 0).obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchDoctors();
    super.onInit();
  }

  void fetchDoctors() async {
    isLoading(true);
    var doctors = await doctorService.getAllDoctors();
    if (doctors != null) {
      doctorsList.assignAll(doctors);
    }
    isLoading(false);
  }

  Future<void> createDoctor(BuildContext context, Doctor newDoctor) async {
    var createdDoctor = await doctorService.createDoctor(newDoctor);
    if (createdDoctor != null) {
      doctorsList.add(createdDoctor);
      Get.snackbar('Doctor creado', 'El doctor ha sido creado con éxito.');
      Navigator.pop(context);
    } else {
      Get.snackbar('Error', 'No se pudo crear el doctor.');
    }
  }

  Future<void> updateDoctor(int id, Doctor updatedDoctor) async {
    var success = await doctorService.updateDoctor(id, updatedDoctor);
    if (success) {
      fetchDoctors();
      Get.snackbar('Doctor actualizado', 'El doctor ha sido actualizado con éxito.');
    } else {
      Get.snackbar('Error', 'No se pudo actualizar el doctor.');
    }
  }

  Future<void> deleteDoctor(int id) async {
    var success = await doctorService.deleteDoctor(id);
    if (success) {
      doctorsList.removeWhere((doctor) => doctor.id == id);
      Get.snackbar('Doctor eliminado', 'El doctor ha sido eliminado.');
    } else {
      Get.snackbar('Error', 'No se pudo eliminar el doctor.');
    }
  }
}
