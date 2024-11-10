class RoutineModel {
  final int id;
  final int idPaciente;
  final String titulo;
  final String descripcion;

  RoutineModel({
    required this.id,
    required this.idPaciente,
    required this.titulo,
    required this.descripcion,
  });

  // Convertir un objeto RoutineModel a JSON para enviar en POST
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idPaciente': idPaciente,
      'titulo': titulo,
      'descripcion': descripcion,
    };
  }

  // Crear una instancia de RoutineModel a partir de JSON recibido
  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      id: json['id'],
      idPaciente: json['idPaciente'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
    );
  }
}
