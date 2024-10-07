import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart'; // Configuración de URL base
import 'package:ulimagym/models/entities/Especialista.dart'; // Modelo de Especialista

class EspecialistaService {
  // Crear un nuevo especialista
  Future<Especialista?> createEspecialista(String especialidad, int idPsicologoGeneral) async {
    String url = "${BASE_URL}especialistas";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "especialidad": especialidad,
          "PsicologoGeneral_id_psicologogeneral": idPsicologoGeneral,
        }),
      );

      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        return Especialista.fromJson(responseBody);
      } else {
        print('Error al crear el especialista: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }


  // Obtener la información de un especialista
  Future<Especialista?> getEspecialista(int idEspecialista) async {
    String url = "${BASE_URL}especialistas/$idEspecialista"; // Endpoint del backend para obtener especialistas

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return Especialista.fromJson(responseBody); // Devolver el objeto Especialista
      } else {
        print('Error al obtener el especialista: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }

  // Actualizar un especialista
  Future<bool> updateEspecialista(int idEspecialista, String nuevaEspecialidad) async {
    String url = "${BASE_URL}especialistas/$idEspecialista"; // Endpoint del backend para actualizar especialistas

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "especialidad": nuevaEspecialidad,
        }),
      );

      if (response.statusCode == 200) {
        return true; // Actualización exitosa
      } else {
        print('Error al actualizar el especialista: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return false;
    }
  }

  // Eliminar un especialista (opcional)
  Future<bool> deleteEspecialista(int idEspecialista) async {
    String url = "${BASE_URL}especialistas/$idEspecialista"; // Endpoint del backend para eliminar especialistas

    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return true; // Eliminación exitosa
      } else {
        print('Error al eliminar el especialista: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return false;
    }
  }
}
