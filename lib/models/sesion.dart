class Sesion {
  final int idSesion;
  final String fecha;
  final String hora;
  final String reporteProgreso;
  final String reporteEmociones;
  final int pacienteId;
  final int psicologoId;

  Sesion({
    required this.idSesion,
    required this.fecha,
    required this.hora,
    required this.reporteProgreso,
    required this.reporteEmociones,
    required this.pacienteId,
    required this.psicologoId,
  });

  // Crear un objeto Sesión desde un JSON
  factory Sesion.fromJson(Map<String, dynamic> json) {
    return Sesion(
      idSesion: json['idSesion'],
      fecha: json['fecha'],
      hora: json['hora'],
      reporteProgreso: json['reporteProgreso'],
      reporteEmociones: json['reporteEmociones'],
      pacienteId: json['pacienteId'],
      psicologoId: json['psicologoId'],
    );
  }

  // Convertir un objeto Sesión a JSON para enviar al backend
  Map<String, dynamic> toJson() {
    return {
      'idSesion': idSesion,
      'fecha': fecha,
      'hora': hora,
      'reporteProgreso': reporteProgreso,
      'reporteEmociones': reporteEmociones,
      'pacienteId': pacienteId,
      'psicologoId': psicologoId,
    };
  }
}
