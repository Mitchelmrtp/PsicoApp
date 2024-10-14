// CuestionarioModel.dart
class CuestionarioModel {
  final int id;
  final String pregunta;

  CuestionarioModel({required this.id, required this.pregunta});

  factory CuestionarioModel.fromJson(Map<String, dynamic> json) {
    return CuestionarioModel(
      id: json['idCuestionario'],
      pregunta: json['pregunta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCuestionario': id,
      'pregunta': pregunta,
    };
  }
}
