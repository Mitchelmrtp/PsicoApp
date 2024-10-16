import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psicoapp/screens/Quest/quest_controller.dart';

class QuestPage extends StatefulWidget {
  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final int idPaciente = 1; 
  List<int?> respuestas = []; 
  int puntajeTotal = 0; 
  String nivelDepresion = ""; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cuestionarioController = Provider.of<CuestionarioController>(context, listen: false);
      cuestionarioController.fetchPreguntas();
    });
  }

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

    if (nivelDepresion == "Moderadamente grave" || nivelDepresion == "Grave") {
      mostrarAlertaUrgente();
    }
  }

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
            respuestas = List.filled(preguntas.length, null); 
          }

          return preguntas.isEmpty
              ? Center(child: CircularProgressIndicator()) 
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
                                        respuestas[index] = value; 
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


          calcularPuntajeTotal();

          final cuestionarioController = Provider.of<CuestionarioController>(context, listen: false);
          try {

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
