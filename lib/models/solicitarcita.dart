import 'dart:convert';

SolicitarCita solicitarCitaFromJson(String str) => SolicitarCita.fromJson(json.decode(str));

String solicitarCitaToJson(SolicitarCita data) => json.encode(data.toJson());

class SolicitarCita {
  int idSolicitarCita;
  DateTime fecha;
  DateTime hora;
  String motivo;
  int pacienteId;

  SolicitarCita({
    required this.idSolicitarCita,
    required this.fecha,
    required this.hora,
    required this.motivo,
    required this.pacienteId,
  });

  factory SolicitarCita.fromJson(Map<String, dynamic> json) => SolicitarCita(
        idSolicitarCita: json["idSolicitarCita"],
        fecha: DateTime.parse(json["fecha"]),
        hora: DateTime.parse(json["hora"]),
        motivo: json["motivo"],
        pacienteId: json["pacienteId"],
      );

  Map<String, dynamic> toJson() => {
        "idSolicitarCita": idSolicitarCita,
        "fecha": fecha.toIso8601String(),
        "hora": hora.toIso8601String(),
        "motivo": motivo,
        "pacienteId": pacienteId,
      };
}
