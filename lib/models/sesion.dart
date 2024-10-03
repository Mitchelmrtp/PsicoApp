class Sesion {
  int id;
  String horarioId;
  String fecha;
  String hora;
  int doctorId;
  int pacienteId;

  Sesion({
    required this.id,
    required this.horarioId,
    required this.fecha,
    required this.hora,
    required this.doctorId,
    required this.pacienteId,
  });

  factory Sesion.fromJson(Map<String, dynamic> json) {
    return Sesion(
      id: json['id'],
      horarioId: json['horarioId'],
      fecha: json['fecha'],
      hora: json['hora'],
      doctorId: json['doctorId'],
      pacienteId: json['pacienteId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'horarioId': horarioId,
      'fecha': fecha,
      'hora': hora,
      'doctorId': doctorId,
      'pacienteId': pacienteId,
    };
  }
}
