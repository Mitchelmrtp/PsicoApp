class Paciente {
  int id;
  String historial;

  Paciente({
    required this.id,
    required this.historial,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'],
      historial: json['historial'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'historial': historial,
    };
  }
}
