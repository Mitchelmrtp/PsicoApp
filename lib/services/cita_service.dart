import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart';
import '../models/cita.dart';

class CitaService {
  Future<Cita?> getCitaById(int id) async {
    final response = await http.get(Uri.parse('$BASE_URL/cita/$id'));

    if (response.statusCode == 200) {
      return Cita.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
