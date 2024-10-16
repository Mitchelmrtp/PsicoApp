import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart'; 
import 'package:psicoapp/models/especialista.dart';

class EspecialistaService {
  Future<Especialista?> createEspecialista(String especialidad, int idPsicologoGeneral) async {
    String url = "${BASE_URL}especialistas";  

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "especialidad": especialidad,
          "PsicologoGeneral_id_psicologogeneral": idPsicologoGeneral,  
        }),
      );

      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        return Especialista.fromJson(responseBody); 
      } else {
        print('Error al crear el especialista: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }
}
