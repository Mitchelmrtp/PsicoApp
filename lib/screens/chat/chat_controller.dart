import 'package:flutter/material.dart';
import 'chat_page.dart';

class UserSelectPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(labelText: 'Sala de chat'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final user = _nameController.text;
                final room = _roomController.text;

                if (user.isNotEmpty && room.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(user: user, roomId: room),
                    ),
                  );
                }
              },
              child: Text('Entrar al Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
