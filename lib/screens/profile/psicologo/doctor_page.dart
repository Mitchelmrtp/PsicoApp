import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/screens/profile/psicologo/doctor_controller.dart';

class DoctorProfilePage extends StatelessWidget {
  final DoctorProfileController controller = Get.put(DoctorProfileController());
  final int doctorId;

  DoctorProfilePage({required this.doctorId});

  @override
  Widget build(BuildContext context) {
    // Cargar los datos del doctor al abrir la página
    controller.loadDoctor(doctorId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del Doctor'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => controller.editDoctorProfile(context),
          ),
        ],
      ),
      body: Obx(() {
        // Mostrar los datos cuando se hayan cargado
        if (controller.doctor.value != null && controller.doctor.value!.id != 0) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nombre: ${controller.doctor.value!.nombre}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Especialidad: ${controller.doctor.value!.especialidadId}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Horario: ${controller.doctor.value!.horarioId}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes añadir la funcionalidad de editar el perfil
                    print('Editar perfil del doctor');
                  },
                  child: Text('Editar Perfil'),
                )
              ],
            ),
          );
        } else {
          // Mostrar un indicador de carga mientras se obtienen los datos
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
