class Especialidad {
  int id;
  String codigo;
  String nomEspecialidad;

  Especialidad({
    required this.id,
    required this.codigo,
    required this.nomEspecialidad,
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    return Especialidad(
      id: json['id'],
      codigo: json['codigo'],
      nomEspecialidad: json['nomEspecialidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'nomEspecialidad': nomEspecialidad,
    };
  }
}
