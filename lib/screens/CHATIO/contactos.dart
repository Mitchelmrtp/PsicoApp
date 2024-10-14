import 'package:flutter/material.dart';
import 'package:psicoapp/screens/CHATIO/chatwid.dart';

class ContactListPage extends StatelessWidget {
  final List<String> contacts;

  ContactListPage({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index]),
            onTap: () {
              // Abrir la sala de chat con el contacto seleccionado
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(roomId: contacts[index], userId: 'usuarioId'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
