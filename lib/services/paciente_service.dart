import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart';
import 'package:psicoapp/models/Paciente.dart'; // Modelo de Paciente

class PacienteService {
  Future<Paciente?> getPacienteByUsuarioId(int usuarioId) async {
    String url = "${BASE_URL}pacientes/$usuarioId"; // Endpoint para obtener el paciente por usuarioId

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return Paciente.fromJson(responseBody); // Devuelve el objeto Paciente
      } else {
        print('Error al obtener el paciente: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }
}
