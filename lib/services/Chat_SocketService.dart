import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connectToRoom(String roomId, String userName) {
    // Establecer conexión con el servidor Socket.IO
    socket = IO.io('http://192.168.18.45:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    // Evento cuando se conecta
    socket.on('connect', (_) {
      print('Conectado al servidor de chat');
      // Unirse a la sala específica (room) del chat
      socket.emit('joinRoom', {'roomId': roomId, 'userName': userName});
    });

    // Evento cuando se recibe un mensaje
    socket.on('receiveMessage', (data) {
      print('Nuevo mensaje de ${data['userName']}: ${data['message']}');
    });

    // Evento cuando se desconecta
    socket.on('disconnect', (_) {
      print('Desconectado del servidor de chat');
    });
  }

  void sendMessage(String roomId, String message, String userName) {
    // Enviar un mensaje al servidor en el room correspondiente
    socket.emit('sendMessage', {
      'roomId': roomId,
      'message': message,
      'userName': userName,
    });
  }

  void disconnect() {
    // Desconectar del servidor
    socket.disconnect();
  }
}
