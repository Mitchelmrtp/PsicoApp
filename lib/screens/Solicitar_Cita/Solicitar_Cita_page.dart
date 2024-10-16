import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/screens/Solicitar_Cita/Solicitar_Cita_controller.dart';

class SolicitarCitaPage extends StatelessWidget {
  final SolicitarCitaController control = Get.put(SolicitarCitaController());
  final Usuario usuarioLogged; 

  // Constructor que recibe el usuario
  SolicitarCitaPage(this.usuarioLogged) {
    control.user = usuarioLogged; 
  }

  @override
  Widget build(BuildContext context) {

    control.checkDayTime();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {

                if (control.selectedDateTime.value == null) {
                  return buildReservationCard(context);
                } else {
                  return buildScheduledCard(context);
                }
              }),
            ),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        child: CustomPaint(
                          painter: PieChartPainter(),
                        ),
                      ),
                      Column(
                        children: [
                          Icon(Icons.sentiment_dissatisfied, size: 100, color: Colors.blue),
                         
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildEmotionIndicator(Colors.green, '15%', Icons.sentiment_very_satisfied),
                      SizedBox(height: 8),
                      buildEmotionIndicator(Colors.yellow, '10%', Icons.sentiment_satisfied),
                      SizedBox(height: 8),
                      buildEmotionIndicator(Colors.purple, '22%', Icons.sentiment_neutral),
                      SizedBox(height: 8),
                      buildEmotionIndicator(Colors.blue, '30%', Icons.sentiment_dissatisfied),
                      SizedBox(height: 8),
                      buildEmotionIndicator(Colors.red, '5%', Icons.sentiment_very_dissatisfied),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),


            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: 0.8,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "80%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Nivel de progreso",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),


Padding(
  padding: const EdgeInsets.all(16.0),
  child: Text(
    'Sugerencias para ti',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  ),
),
Center(  
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Wrap(
      alignment: WrapAlignment.center, 
      spacing: 16,
      runSpacing: 16,
      children: [
        buildSuggestionCard('Tips para un ambiente laboral sano',
            'assets/images/laboral.png'),
        buildSuggestionCard(
            'Ser productivo sin desgastarse', 'assets/images/productivo.png'),
        buildSuggestionCard('Importancia de una buena alimentación',
            'assets/images/alimentacion.png'),
        buildSuggestionCard(
            '5 tips de meditación para tu tiempo libre', 'assets/images/meditacion.png'),
      ],
    ),
  ),
),
SizedBox(height: 24),

          ],
        ),
      ),
    );
  }

  // Widget para la tarjeta de reserva de cita
  Widget buildReservationCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sin Eventos',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'CPI-Válidamente',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Icon(
                      control.isDayTime.value ? Icons.wb_sunny : Icons.nights_stay,
                      color: control.isDayTime.value ? Colors.yellow : Colors.blue,
                      size: 50,
                    )),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => control.selectDateTime(context), // Llamar a la selección de fecha, hora y motivo
                  child: Text('Reservar Cita'),
                ),

            ),
          ],
        ),
      ),
    );
  }

  // Widget para la tarjeta de la cita agendada
  Widget buildScheduledCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diagnóstico Psicológico',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Primera Sesión',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Icon(
                      control.isDayTime.value ? Icons.wb_sunny : Icons.nights_stay,
                      color: control.isDayTime.value ? Colors.yellow : Colors.blue,
                      size: 50,
                    )),
              ],
            ),
            Spacer(),
            Text(
              DateFormat('hh:mm a').format(control.selectedDateTime.value!),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => control.rescheduleCita(context),
                  child: Text(
                    'Reagendar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    control.selectedDateTime.value = null;
                  },
                  child: Text(
                    'Cancelar Cita',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget para crear una tarjeta de sugerencia
Widget buildSuggestionCard(String title, String assetPath) {
  return Container(
    width: 160,
    height: 160,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        image: AssetImage(assetPath),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      padding: EdgeInsets.all(8),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Spacer(), 
          Text(
            title,
            textAlign: TextAlign.center, 
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

  // Widget para crear un ítem de emoción
  Widget buildEmotionIndicator(Color color, String percentage, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 8),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Clase personalizada para la gráfica circular de emociones
class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Offset center = Offset(width / 2, height / 2);
    double radius = width / 2;

    Paint paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 30;

    double startAngle = -90;
    final angles = [54, 36, 79.2, 108, 72]; 

    final colors = [
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.blue,
      Colors.red,
    ];

    for (int i = 0; i < angles.length; i++) {
      final sweepAngle = angles[i].toDouble(); 
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreesToRadians(startAngle),
        degreesToRadians(sweepAngle),
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
