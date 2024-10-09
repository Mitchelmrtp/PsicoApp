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
      return false;
    }
  }

  
}
