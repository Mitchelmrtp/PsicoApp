// cuestionario_service.dart
import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart';
import 'dart:convert';

class CuestionarioService {
  // Obtiene todos los cuestionarios desde el backend
  Future<List<dynamic>> getAllCuestionarios() async {
    final url = Uri.parse('${BASE_URL}cuestionarios');
    print('Haciendo solicitud GET a: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Preguntas recibidas: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los cuestionarios: ${response.statusCode}');
    }
  }

  // Enviar respuestas al backend
  Future<void> enviarRespuesta(Map<String, dynamic> respuesta) async {
    final url = Uri.parse('${BASE_URL}respuestas');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(respuesta),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al enviar la respuesta: ${response.statusCode}');
    }
  }
}
