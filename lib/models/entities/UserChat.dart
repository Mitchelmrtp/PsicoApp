import 'dart:convert';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  int id;
  String username;
  String createdAt;

  // Constructor vacío
  UserChat.empty()
      : id = 0,
        username = '',
        createdAt = '';

  // Constructor con parámetros
  UserChat({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  // Crear instancia de UserChat desde JSON
  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["id"],
        username: json["username"],
        createdAt: json["created_at"],
      );

  // Convertir instancia de UserChat a JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "created_at": createdAt,
      };

  @override
  String toString() {
    return 'UserChat -> id: $id, username: $username, created_at: $createdAt';
  }
}
