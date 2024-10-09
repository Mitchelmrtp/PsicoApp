import 'dart:convert';

Especialista especialistaFromJson(String str) => Especialista.fromJson(json.decode(str));

String especialistaToJson(Especialista data) => json.encode(data.toJson());

class Especialista {
  int id;
  String especialidad;
  int psicologoGeneralId;

  // Constructor vacío para inicialización predeterminada
  Especialista.empty()
      : id = 0,
        especialidad = '',
        psicologoGeneralId = 0;

  Especialista({
    required this.id,
    required this.especialidad,
    required this.psicologoGeneralId,
  });

  // Método copyWith para actualizar campos específicos
  Especialista copyWith({
    int? id,
    String? especialidad,
    int? psicologoGeneralId,
  }) {
    return Especialista(
      id: id ?? this.id,
      especialidad: especialidad ?? this.especialidad,
      psicologoGeneralId: psicologoGeneralId ?? this.psicologoGeneralId,
    );
  }

  // Método para crear un objeto Especialista desde JSON
  factory Especialista.fromJson(Map<String, dynamic> json) => Especialista(
        id: json["id_especialista"],
        especialidad: json["especialidad"],
        psicologoGeneralId: json["psicologoGeneral_id_psicologogeneral"],
      );

  // Método para convertir un objeto Especialista a JSON
  Map<String, dynamic> toJson() => {
        "id_especialista": id,
        "especialidad": especialidad,
        "psicologoGeneral_id_psicologogeneral": psicologoGeneralId,
      };

  @override
  String toString() {
    return 'Especialista -> id: $id, especialidad: $especialidad, psicologoGeneralId: $psicologoGeneralId';
  }
}
