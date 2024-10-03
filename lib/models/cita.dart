class Cita {
  int id;
  String fecha;
  String hora;

  Cita({
    required this.id,
    required this.fecha,
    required this.hora,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
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
