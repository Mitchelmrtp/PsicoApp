// quest_controller.dart
import 'package:flutter/material.dart';
import 'package:psicoapp/models/CuestionarioModel.dart';
import 'package:psicoapp/models/RespuestaModel.dart'; // Asegúrate de importar el modelo de respuesta
import 'package:psicoapp/services/cuestionario_service.dart';

class CuestionarioController with ChangeNotifier {
  List<CuestionarioModel> _preguntas = [];
  final CuestionarioService _cuestionarioService = CuestionarioService();

  List<CuestionarioModel> get preguntas => _preguntas;

  // Obtener preguntas
  Future<void> fetchPreguntas() async {
    try {
      List<dynamic> data = await _cuestionarioService.getAllCuestionarios();
      _preguntas = data.map((item) => CuestionarioModel.fromJson(item)).toList();
      notifyListeners();
    } catch (e) {
      print('Error al obtener las preguntas: $e');
    }
  }

  // Enviar respuestas usando RespuestaModel
  Future<void> enviarRespuestas(int idPaciente, List<int> respuestas) async {
    try {
      for (int i = 0; i < _preguntas.length; i++) {
        // Crear instancia de RespuestaModel
        RespuestaModel respuestaModel = RespuestaModel(
          idCuestionario: _preguntas[i].id,
          idPaciente: idPaciente,
          respuesta: respuestas[i],
        );
        // Enviar la respuesta al backend
        await _cuestionarioService.enviarRespuesta(respuestaModel.toJson());
      }
    } catch (e) {
      print('Error al enviar las respuestas: $e');
      throw e;
    }
  }
}
