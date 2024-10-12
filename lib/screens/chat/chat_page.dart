import 'package:flutter/material.dart';
import 'package:psicoapp/services/Chat_SocketService.dart';

class ChatPage extends StatefulWidget {
  final String user;
  final String roomId;

  const ChatPage({Key? key, required this.user, required this.roomId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late SocketService socketService;

  @override
  void initState() {
    super.initState();
    socketService = SocketService();
    // Conectar al room específico basado en el roomId
    socketService.connectToRoom(widget.roomId, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat - ${widget.user}'), // Mostrar el nombre del usuario
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 0, // Aquí iría la cantidad de mensajes
              itemBuilder: (context, index) {
                // Mostrar los mensajes
                return ListTile(title: Text("Mensaje $index"));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Escribe un mensaje..."),
                    onSubmitted: (text) {
                      socketService.sendMessage(widget.roomId, text, widget.user);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Aquí enviamos el mensaje
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
