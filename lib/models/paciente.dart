import 'dart:convert';

Paciente pacienteFromJson(String str) => Paciente.fromJson(json.decode(str));

String pacienteToJson(Paciente data) => json.encode(data.toJson());

class Paciente {
  int idPaciente;
  int usuarioId;

  Paciente({
    required this.idPaciente,
    required this.usuarioId,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        idPaciente: json["idPaciente"],
        usuarioId: json["Usuario_id_usuario"],
      );

  Map<String, dynamic> toJson() => {
        "idPaciente": idPaciente,
        "Usuario_id_usuario": usuarioId,
      };
}
