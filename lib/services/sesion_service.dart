import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart';
import 'package:psicoapp/models/sesion.dart';
import 'dart:convert';

class SesionService {
  // Crear una nueva sesión
  Future<void> createSesion(Sesion sesion) async {
    final response = await http.post(
      Uri.parse('${BASE_URL}sesiones'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(sesion.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la sesión');
    }
  }
}
