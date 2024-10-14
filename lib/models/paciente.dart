class Paciente {
  final int idPaciente;  // Coincide con idPaciente en la tabla SQL
  final String historial; // Coincide con historial en la tabla SQL
  final int usuarioId; // Coincide con Usuario_id_usuario en la tabla SQL

  Paciente({
    required this.idPaciente,
    required this.historial,
    required this.usuarioId,
  });

  // Crear un objeto Paciente desde un JSON
  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      idPaciente: json['idPaciente'],
      historial: json['historial'] ?? '',  // Para manejar el caso si historial es nulo
      usuarioId: json['Usuario_id_usuario'],
    );
  }

  // Convertir un objeto Paciente a JSON (si es necesario)
  Map<String, dynamic> toJson() {
    return {
      'idPaciente': idPaciente,
      'historial': historial,
      'Usuario_id_usuario': usuarioId,
    };
  }
}
