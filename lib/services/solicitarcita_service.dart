import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart';

class CitaService {
  Future<bool> createCita(int pacienteId, DateTime fechaHora, String motivo) async {
    // Convierte la fecha a formato ISO si es necesario
    String fechaHoraString = fechaHora.toIso8601String();
    String url = "${BASE_URL}citas";

    // Enviar solicitud POST para crear la cita
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "pacienteId": pacienteId, // Enviar el ID del paciente al backend
        "fechaHora": fechaHoraString,
        "motivo": motivo,
      }),
    );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error: ${response.body}'); // Muestra el error en la consola
        return false;
      }

  }

  Future<bool> updateCita(int citaId, int pacienteId, DateTime fechaHora, String motivo) async {
    String fechaHoraString = fechaHora.toIso8601String();
    String url = "${BASE_URL}citas/$citaId"; // Usamos el ID de la cita para la actualización

    // Enviar solicitud PUT para actualizar la cita
    var response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "pacienteId": pacienteId,
        "fechaHora": fechaHoraString,
        "motivo": motivo,
      }),
    );

    if (response.statusCode == 200) { // 200 significa que la actualización fue exitosa
      return true;
    } else {
      print('Error: ${response.body}');
      return false;
    }
  }

  
}
