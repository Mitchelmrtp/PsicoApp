import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart';
import 'package:ulimagym/models/entities/UserChat.dart';
import 'dart:convert';

class ChatPage extends StatefulWidget {
  final int conversationId;
  final UserChat userChat; // Información del usuario

  ChatPage({required this.conversationId, required this.userChat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List messages = [];
  bool isLoading = true;
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    var url = Uri.parse('${BASE_URL}conversations/${widget.conversationId}/messages');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        messages = jsonData['messages'];
        isLoading = false;
      });
    }
  }

  Future<void> _sendMessage(String text) async {
    var url = Uri.parse('${BASE_URL}conversations/${widget.conversationId}/messages');
    var response = await http.post(url, body: {
      'sender': widget.userChat.username,
      'text': text,
    });

    if (response.statusCode == 200) {
      _loadMessages(); // Recargar mensajes
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    bool isSentByUser = message['sender'] == widget.userChat.username;
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSentByUser ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment:
              isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message['text'], style: TextStyle(color: Colors.black)),
            Text(message['timestamp'], style: TextStyle(fontSize: 10, color: Colors.black45)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF112244),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
            ),
            SizedBox(width: 10),
            Text('Chat - ${widget.userChat.username}'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(messages[index]);
                    },
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
