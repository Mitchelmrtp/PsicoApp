import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart';
import '../models/entities/doctor.dart';

class DoctorService {
  Future<Doctor?> getDoctorById(int id) async {
    String url = "${BASE_URL}doctors/$id";  // Endpoint del backend para obtener los datos del doctor

    try {
      // Enviar solicitud GET usando http
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        // Convertir la respuesta a un objeto Doctor
        final Doctor doctor = Doctor.fromJson(responseBody);
        return doctor;
      } else {
        print('Error al obtener los datos del doctor');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }
}
