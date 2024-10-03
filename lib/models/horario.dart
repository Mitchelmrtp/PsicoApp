class Horario {
  int id;
  String fecha;
  String hora;

  Horario({
    required this.id,
    required this.fecha,
    required this.hora,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      id: json['id'],
      fecha: json['fecha'],
      hora: json['hora'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha,
      'hora': hora,
    };
  }
}
