import 'package:flutter/material.dart';
import 'package:psicoapp/screens/chat/chat_page.dart';

class PsychologistChatListPage extends StatelessWidget {
  final List<String> patients; // Lista de pacientes asignados al psicólogo

  PsychologistChatListPage({Key? key, required this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats de Pacientes"),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(patients[index]),
            onTap: () {
              // Navegar al chat con el paciente seleccionado
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    user: "Psicologo", // Nombre del psicólogo
                    roomId: patients[index], // El paciente es la sala
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
