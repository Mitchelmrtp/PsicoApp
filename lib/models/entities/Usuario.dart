import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int id;
  String nombreCompleto;
  String correo;
  String DNI;
  String tipoUsuario;
  String numeroCelular;
  String contrasena;
  bool admin;

  Usuario.empty()
      : id = 0,
        nombreCompleto = '',
        correo = '',
        DNI = '',
        tipoUsuario = '',
        numeroCelular = '',
        contrasena = '',
        admin = false;

  Usuario({
    required this.id,
    required this.nombreCompleto,
    required this.correo,
    required this.DNI,
    required this.tipoUsuario,
    required this.numeroCelular,
    required this.contrasena,
    required this.admin,
  });

  // Método copyWith para actualizar campos específicos
  Usuario copyWith({
    int? id,
    String? nombreCompleto,
    String? correo,
    String? DNI,
    String? tipoUsuario,
    String? numeroCelular,
    String? contrasena,
    bool? admin,
  }) {
    return Usuario(
      id: id ?? this.id,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      correo: correo ?? this.correo,
      DNI: DNI ?? this.DNI,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      numeroCelular: numeroCelular ?? this.numeroCelular,
      contrasena: contrasena ?? this.contrasena,
      admin: admin ?? this.admin,
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombreCompleto: json["nombreCompleto"],
        correo: json["correo"],
        DNI: json["DNI"],
        tipoUsuario: json["tipoUsuario"],
        numeroCelular: json["numeroCelular"],
        contrasena: json["contrasena"],
        admin: json["Admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreCompleto": nombreCompleto,
        "correo": correo,
        "DNI": DNI,
        "tipoUsuario": tipoUsuario,
        "numeroCelular": numeroCelular,
        "contrasena": contrasena,
        "Admin": admin,
      };

  @override
  String toString() {
    return 'Usuario -> id: $id, nombreCompleto: $nombreCompleto, correo: $correo, DNI: $DNI, tipoUsuario: $tipoUsuario, numeroCelular: $numeroCelular, contrasena: $contrasena, admin: $admin';
  }
}
