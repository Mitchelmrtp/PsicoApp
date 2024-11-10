import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _sessionIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emotionalStateController =
      TextEditingController();
  final TextEditingController _topicsController = TextEditingController();
  final TextEditingController _difficultiesController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Llenar Reporte")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sesion ID"),
              TextField(
                controller: _sessionIdController,
                decoration: InputDecoration(
                  hintText: "Ingrese ID de sesión",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text("Fecha"),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: "Ingrese la fecha",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text("Estado Emocional"),
              TextField(
                controller: _emotionalStateController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Ingrese estado emocional",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType
                    .multiline,
              ),
              SizedBox(height: 16),
              Text("Temas Tratados"),
              TextField(
                controller: _topicsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Ingrese los temas tratados",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 16),
              Text("Dificultades"),
              TextField(
                controller: _difficultiesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Ingrese las dificultades",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 16),
              Text("Comentarios"),
              TextField(
                controller: _commentsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Ingrese comentarios",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  print("Reporte enviado");
                },
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
