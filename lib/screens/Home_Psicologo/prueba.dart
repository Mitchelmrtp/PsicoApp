import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


class PruebaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fecha de Reserva
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateButton('27 NOV'),
                SizedBox(width: 20),
                DateButton('28 NOV', isMain: true),
                SizedBox(width: 20),
                DateButton('29 NOV'),
              ],
            ),
            SizedBox(height: 20),

            // Indicador de progreso circular y emociones
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 130.0,
                        lineWidth: 13.0,
                        percent: 0.80,
                        center: Icon(Icons.mood_bad, size: 50, color: Colors.blue),
                        progressColor: Colors.blueAccent,
                        backgroundColor: Colors.grey[200]!,
                      ),
                      Positioned(
                        bottom: 20,
                        child: Text(
                          "80%\nNivel de progreso",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Gráfico de emociones con porcentajes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmotionIcon(Colors.green, 15, Icons.sentiment_very_satisfied),
                      EmotionIcon(Colors.yellow, 10, Icons.sentiment_satisfied),
                      EmotionIcon(Colors.purple, 22, Icons.sentiment_neutral),
                      EmotionIcon(Colors.orange, 30, Icons.sentiment_dissatisfied),
                      EmotionIcon(Colors.red, 5, Icons.sentiment_very_dissatisfied),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Sección de Sugerencias
            Text(
              'Sugerencias para ti',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  SuggestionCard('Tips para un ambiente laboral sano', 'assets/laboral.png'),
                  SuggestionCard('Ser productivo sin desgastarse', 'assets/productivo.png'),
                  SuggestionCard('Importancia de una buena alimentación', 'assets/alimentacion.png'),
                  SuggestionCard('5 tips de meditación para tu tiempo libre', 'assets/meditacion.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateButton extends StatelessWidget {
  final String text;
  final bool isMain;

  DateButton(this.text, {this.isMain = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isMain ? Colors.orange : Colors.white,  // Color principal del botón
        foregroundColor: isMain ? Colors.white : Colors.black,  // Color del texto
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class EmotionIcon extends StatelessWidget {
  final Color color;
  final int percentage;
  final IconData icon;

  EmotionIcon(this.color, this.percentage, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        SizedBox(height: 5),
        Text('$percentage%', style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final String title;
  final String imagePath;

  SuggestionCard(this.title, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
