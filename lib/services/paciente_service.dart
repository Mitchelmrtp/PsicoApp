import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart';
import '../models/entities/paciente.dart';

class PacienteService {
  Future<Paciente?> getPacienteById(int id) async {
    final response = await http.get(Uri.parse('$BASE_URL/paciente/$id'));

    if (response.statusCode == 200) {
      return Paciente.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
