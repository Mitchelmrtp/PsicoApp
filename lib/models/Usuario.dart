import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int id;
  String nombre;
  String apellido;
  String correo;
  String DNI;
  String numeroCelular;
  String contrasena;
  DateTime? fechaNacimiento;
  String rol;

  // Constructor vacío para inicialización predeterminada
  Usuario.empty()
      : id = 0,
        nombre = '',
        apellido = '',
        correo = '',
        DNI = '',
        numeroCelular = '',
        contrasena = '',
        fechaNacimiento = null,
        rol = 'Paciente'; // Por defecto, 'Paciente'

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.DNI,
    required this.numeroCelular,
    required this.contrasena,
    this.fechaNacimiento,
    required this.rol,

  });

  // Método copyWith para actualizar campos específicos
  Usuario copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? correo,
    String? DNI,
    String? numeroCelular,
    String? contrasena,
    DateTime? fechaNacimiento,
    String? rol,
  }) {
    return Usuario(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      correo: correo ?? this.correo,
      DNI: DNI ?? this.DNI,
      numeroCelular: numeroCelular ?? this.numeroCelular,
      contrasena: contrasena ?? this.contrasena,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      rol: rol ?? this.rol,
    );
  }

  // Método para crear un objeto Usuario desde JSON
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id_usuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        DNI: json["DNI"],
        numeroCelular: json["NumCelular"],
        contrasena: json["contrasena"],
        fechaNacimiento: json["fecha_nacimiento"] != null
            ? DateTime.parse(json["fecha_nacimiento"])
            : null,
        rol: json["rol"], // Agregar el rol desde el JSON
      );

  // Método para convertir un objeto Usuario a JSON
  Map<String, dynamic> toJson() => {
        "id_usuario": id,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "DNI": DNI,
        "NumCelular": numeroCelular,
        "contrasena": contrasena,
        "fecha_nacimiento": fechaNacimiento?.toIso8601String(),
        "rol": rol,  // Agregar el rol al JSON

      };

  @override
  String toString() {
    return 'Usuario -> id: $id, nombre: $nombre, apellido: $apellido, correo: $correo, DNI: $DNI, numeroCelular: $numeroCelular, contrasena: $contrasena, rol: $rol';
  }
}
