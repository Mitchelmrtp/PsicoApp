import 'package:flutter/material.dart';
import 'package:psicoapp/services/socketio.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  final String userId;

  const ChatPage({required this.roomId, required this.userId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _chatService.connectSocket(widget.userId);
    _chatService.joinRoom(widget.roomId);

    _chatService.socket.on('receive_message', (data) {
      setState(() {
        _messages.add(data['message']);
      });
    });
  }

  @override
  void dispose() {
    _chatService.disconnectSocket();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      _chatService.sendMessage(widget.roomId, message);
      setState(() {
        _messages.add(message);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Escribe un mensaje...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
