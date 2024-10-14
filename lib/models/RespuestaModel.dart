// RespuestaModel.dart
class RespuestaModel {
  final int idCuestionario;
  final int idPaciente;
  final int respuesta;

  RespuestaModel({
    required this.idCuestionario,
    required this.idPaciente,
    required this.respuesta,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCuestionario': idCuestionario,
      'idPaciente': idPaciente,
      'respuesta': respuesta,
    };
  }
}
