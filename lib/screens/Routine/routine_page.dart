// screens/Routine/RoutinePage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psicoapp/screens/Routine/routine_controller.dart';
import 'package:psicoapp/models/RoutineModel.dart';

class RoutinePage extends StatefulWidget {
  final String role;
  final String token;

  RoutinePage({required this.role, required this.token});

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routineController =
          Provider.of<RoutineController>(context, listen: false);
      routineController.fetchRoutine(
          1, widget.token); // Cambia el ID de rutina según sea necesario
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rutina")),
      body: Consumer<RoutineController>(
        builder: (context, routineController, child) {
          final routine = routineController.routine;
          return routine == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Título: ${routine.titulo}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("Descripción: ${routine.descripcion}"),
                      if (widget.role == "psychologist")
                        ElevatedButton(
                          onPressed: () async {
                            RoutineModel newRoutine = RoutineModel(
                              id: 2, // Cambia el ID según sea necesario
                              idPaciente: routine.idPaciente,
                              titulo: "Nueva Rutina",
                              descripcion: "Descripción de la nueva rutina",
                            );
                            try {
                              await routineController.createRoutine(
                                  newRoutine, widget.token);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Rutina creada exitosamente")),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Error al crear la rutina")),
                              );
                            }
                          },
                          child: Text("Crear Rutina"),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
