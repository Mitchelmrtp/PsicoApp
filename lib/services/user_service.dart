import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ulimagym/configs/constants.dart';
import '../models/entities/Usuario.dart';

class UserService {
  Future<Usuario?> validate(String email, String password) async {
    String url = "${BASE_URL}usuarios/validate";

    try {
      // Enviar solicitud POST usando http.post
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correo": email,
          "contrasena": password
        }),
      );

      // Verificar si el código de estado es 200 (éxito)
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        // Convertir la respuesta a un objeto Usuario
        final Usuario usuario = Usuario.fromJson(responseBody);
        return usuario;
      } else if (response.statusCode == 404) {
        // Si no se encuentra el usuario
        return null;
      } else {
        print('Error de validación: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }



 Future<Usuario?> register(
      String nombreCompleto, String correo, String dni, String tipoUsuario,
      String numeroCelular, String contrasena) async {
    String url = "${BASE_URL}usuarios";  // Ruta de creación de usuario

    try {
      // Enviar solicitud POST al backend
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nombreCompleto": nombreCompleto,
          "correo": correo,
          "DNI": dni,
          "tipoUsuario": tipoUsuario,
          "numeroCelular": numeroCelular,
          "contrasena": contrasena,
          "Admin": false  // Por defecto, no es administrador
        }),
      );

      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        final Usuario usuario = Usuario.fromJson(responseBody);  // Convertimos el JSON a un objeto Usuario
        return usuario;
      } else {
        print('Error de registro: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }


  
  Future<String?> reset(String dni, String email) async {
    String url = "${BASE_URL}user/reset";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['dni'] = dni;
    request.fields['email'] = email;
    try {
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final String r = responseBody;
        return r;
      } else if (response.statusCode == 404) {
        var responseBody = await response.stream.bytesToString();
        final String r = responseBody;
        return r;
      } else {
        print('ERROORRR!!!');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
  }
}
