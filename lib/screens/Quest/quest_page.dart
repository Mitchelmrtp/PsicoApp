// quest_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psicoapp/screens/Quest/quest_controller.dart';

class QuestPage extends StatefulWidget {
  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final int idPaciente = 1; // Cambia esto por el ID real del paciente
  List<int?> respuestas = []; // Lista para almacenar las respuestas seleccionadas
  int puntajeTotal = 0; // Variable para almacenar el puntaje total
  String nivelDepresion = ""; // Almacena el nivel de depresión

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cuestionarioController = Provider.of<CuestionarioController>(context, listen: false);
      cuestionarioController.fetchPreguntas(); // Cargar preguntas al iniciar
    });
  }

  // Función para calcular el puntaje total basado en las respuestas
  void calcularPuntajeTotal() {
    puntajeTotal = respuestas.whereType<int>().fold(0, (sum, item) => sum + item);

    if (puntajeTotal <= 4) {
      nivelDepresion = "Mínimo";
    } else if (puntajeTotal <= 9) {
      nivelDepresion = "Leve";
    } else if (puntajeTotal <= 14) {
      nivelDepresion = "Moderado";
    } else if (puntajeTotal <= 19) {
      nivelDepresion = "Moderadamente grave";
    } else {
      nivelDepresion = "Grave";
    }

    // Si el nivel es Moderadamente grave o Grave, mostrar alerta de urgencia
    if (nivelDepresion == "Moderadamente grave" || nivelDepresion == "Grave") {
      mostrarAlertaUrgente();
    }
  }

  // Mostrar alerta para solicitar cita de forma urgente
  void mostrarAlertaUrgente() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Urgente: Solicitar cita'),
        content: Text(
            'Tu nivel de depresión es $nivelDepresion. Te recomendamos que solicites una cita urgente para recibir atención profesional.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test de Síntomas de Depresión (PHQ-9)'),
      ),
      body: Consumer<CuestionarioController>(
        builder: (context, cuestionarioController, child) {
          final preguntas = cuestionarioController.preguntas;
          if (respuestas.length != preguntas.length) {
            respuestas = List.filled(preguntas.length, null); // Inicializa la lista de respuestas
          }

          return preguntas.isEmpty
              ? Center(child: CircularProgressIndicator()) // Indicador de carga
              : ListView.builder(
                  itemCount: preguntas.length,
                  itemBuilder: (context, index) {
                    final pregunta = preguntas[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${pregunta.pregunta}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (i) {
                              return Row(
                                children: [
                                  Radio<int>(
                                    value: i,
                                    groupValue: respuestas[index],
                                    onChanged: (value) {
                                      setState(() {
                                        respuestas[index] = value; // Captura la respuesta seleccionada
                                      });
                                    },
                                  ),
                                  Text('$i'),
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Asegurarse de que todas las respuestas estén completas
          if (respuestas.contains(null)) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Por favor, responde todas las preguntas antes de enviar.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
            return;
          }

          // Calcular el puntaje total y el nivel de depresión
          calcularPuntajeTotal();

          final cuestionarioController = Provider.of<CuestionarioController>(context, listen: false);
          try {
            // Enviar respuestas
            await cuestionarioController.enviarRespuestas(idPaciente, respuestas.cast<int>());
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Respuestas enviadas'),
                content: Text(
                    'Tus respuestas han sido enviadas. Tu nivel de depresión es $nivelDepresion con un puntaje total de $puntajeTotal.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('No se pudieron enviar las respuestas. Inténtalo de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
