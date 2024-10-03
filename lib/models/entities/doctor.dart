import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  int id;
  String nombre;
  int especialidadId;
  int horarioId;

  Doctor({
    required this.id,
    required this.nombre,
    required this.especialidadId,
    required this.horarioId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        nombre: json["nombre"],
        especialidadId: json["especialidadId"],
        horarioId: json["horarioId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "especialidadId": especialidadId,
        "horarioId": horarioId,
      };
}
