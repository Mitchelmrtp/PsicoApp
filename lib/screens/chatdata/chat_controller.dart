import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart';
import 'package:ulimagym/models/entities/UserChat.dart';
import 'dart:convert';


class ChatController extends GetxController {
  var messages = [].obs;
  var isLoading = false.obs;
  UserChat? userChat;

  // Inicializar el controlador con un usuario
  ChatController({this.userChat});

  // Obtener todos los mensajes de una conversación
  Future<void> getMessages(int conversationId) async {
    isLoading(true);
    var url = Uri.parse('${BASE_URL}conversations/$conversationId/messages');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        messages.value = jsonData['messages'];
      }
    }
    isLoading(false);
  }

  // Enviar un mensaje
  Future<void> sendMessage(int conversationId, String text) async {
    var url = Uri.parse('${BASE_URL}conversations/$conversationId/messages');
    var response = await http.post(url, body: {
      'sender': userChat?.username ?? 'Unknown',  // Usa el nombre del usuario o 'Unknown'
      'text': text,
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        getMessages(conversationId); // Refrescar mensajes
      }
    }
  }
}
