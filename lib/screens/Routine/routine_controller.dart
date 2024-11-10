// screens/controllers/routine_controller.dart

import 'package:flutter/material.dart';
import 'package:psicoapp/models/RoutineModel.dart';
import 'package:psicoapp/services/routine_service.dart';

class RoutineController with ChangeNotifier {
  RoutineModel? _routine;
  final RoutineService _routineService = RoutineService();

  RoutineModel? get routine => _routine;

  // Obtener la rutina por ID
  Future<void> fetchRoutine(int id, String token) async {
    try {
      RoutineModel? data = await _routineService.getRoutine(id, token);
      _routine = data;
      notifyListeners();
    } catch (e) {
      print('Error al obtener la rutina: $e');
    }
  }

  // Crear una nueva rutina
  Future<void> createRoutine(RoutineModel newRoutine, String token) async {
    try {
      await _routineService.createRoutine(newRoutine, token);
      fetchRoutine(newRoutine.id, token); // Actualizar con la nueva rutina
    } catch (e) {
      print('Error al crear la rutina: $e');
      throw e;
    }
  }
}
