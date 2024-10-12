class ChatMessage {
  final String user;
  final String message;

  ChatMessage({required this.user, required this.message});

  // Método para convertir desde un JSON (opcional, si deseas usarlo en caso de guardar o recibir mensajes del backend)
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      user: json['user'],
      message: json['message'],
    );
  }

  // Método para convertir a un JSON (opcional, útil si se almacenan los mensajes en el backend)
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'message': message,
    };
  }
}
