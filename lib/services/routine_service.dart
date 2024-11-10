// services/routine_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/RoutineModel.dart';
import 'package:psicoapp/configs/constants.dart';

class RoutineService {
  // Método para obtener una rutina específica
  Future<RoutineModel?> getRoutine(int id, String token) async {
    final url = Uri.parse('${BASE_URL}rutina/$id');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return RoutineModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener la rutina: ${response.statusCode}');
    }
  }

  // Método para crear una nueva rutina
  Future<void> createRoutine(RoutineModel routine, String token) async {
    final url = Uri.parse('${BASE_URL}rutina');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(routine.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la rutina: ${response.statusCode}');
    }
  }
}
