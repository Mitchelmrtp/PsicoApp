import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;

  void connectSocket(String userId) {
    // Configurar la conexión con el servidor
    socket = IO.io('http://192.168.18.45:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // Escuchar eventos
    socket.on('connect', (_) {
      print('Conectado al servidor con el ID del usuario: $userId');
    });

    // Escuchar desconexiones
    socket.on('disconnect', (_) {
      print('Desconectado del servidor');
    });
  }

  // Método para unirse a una sala
  void joinRoom(String roomId) {
    socket.emit('join_room', {'roomId': roomId});
    print('Unido a la sala: $roomId');
  }

  // Método para enviar mensajes
  void sendMessage(String roomId, String message) {
    socket.emit('send_message', {'roomId': roomId, 'message': message});
    print('Mensaje enviado a la sala $roomId: $message');
  }

  // Método para escuchar los mensajes
  void listenMessages(Function(String) onMessage) {
    socket.on('receive_message', (data) {
      String message = data['message'];
      onMessage(message);
    });
  }

  void disconnectSocket() {
    socket.disconnect();
  }
}
