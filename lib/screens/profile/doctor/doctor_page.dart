import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/models/entities/Doctor.dart';
import 'package:ulimagym/services/doctor_service.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  DoctorService doctorService = DoctorService();
  List<Doctor> doctors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  fetchDoctors() async {
    List<Doctor>? fetchedDoctors = await doctorService.getAllDoctors();
    if (fetchedDoctors != null) {
      setState(() {
        doctors = fetchedDoctors;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Doctores'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return ListTile(
                  title: Text(doctor.nombre),
                  subtitle: Text('Especialidad ID: ${doctor.especialidadId}'),
                  onTap: () {
                    // Manejar acción al seleccionar un doctor
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Abrir formulario para crear doctor
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
