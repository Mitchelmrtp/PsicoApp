import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart'; // Configuración de URL base
import 'package:psicoapp/models/especialista.dart'; // Modelo de Especialista

class EspecialistaService {
  // Método para crear un especialista
  Future<Especialista?> createEspecialista(String especialidad, int idPsicologoGeneral) async {
    String url = "${BASE_URL}especialistas";  // Ruta del endpoint de especialistas

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "especialidad": especialidad,
          "PsicologoGeneral_id_psicologogeneral": idPsicologoGeneral,  // Enviar el id del PsicologoGeneral.
        }),
      );

      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        return Especialista.fromJson(responseBody);  // Crear instancia de Especialista desde la respuesta
      } else {
        print('Error al crear el especialista: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }
}
