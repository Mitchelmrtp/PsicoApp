import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulimagym/models/entities/Doctor.dart';
import '../configs/constants.dart'; // Asegúrate de tener BASE_URL en constants.dart

class DoctorService {
  Future<List<Doctor>?> getAllDoctors() async {
    try {
      final response = await http.get(Uri.parse('${BASE_URL}doctors'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((doc) => Doctor.fromJson(doc)).toList();
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    }
    return null;
  }

  Future<Doctor?> getDoctorById(int id) async {
    try {
      final response = await http.get(Uri.parse('${BASE_URL}doctors/$id'));
      if (response.statusCode == 200) {
        return Doctor.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print('Error fetching doctor by ID: $e');
    }
    return null;
  }

  Future<Doctor?> createDoctor(Doctor doctor) async {
    try {
      final response = await http.post(
        Uri.parse('${BASE_URL}doctors'),
        headers: {'Content-Type': 'application/json'},
        body: doctorToJson(doctor),
      );
      if (response.statusCode == 201) {
        return Doctor.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print('Error creating doctor: $e');
    }
    return null;
  }

  Future<bool> updateDoctor(int id, Doctor doctor) async {
    try {
      final response = await http.put(
        Uri.parse('${BASE_URL}doctors/$id'),
        headers: {'Content-Type': 'application/json'},
        body: doctorToJson(doctor),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating doctor: $e');
    }
    return false;
  }

  Future<bool> deleteDoctor(int id) async {
    try {
      final response = await http.delete(Uri.parse('${BASE_URL}doctors/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting doctor: $e');
    }
    return false;
  }
}
