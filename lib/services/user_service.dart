import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:psicoapp/configs/constants.dart';
import '../models/Usuario.dart';

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

  Future<Usuario?> updateUsuario(Usuario usuario, {String? imagePath}) async {
    String url = "${BASE_URL}usuarios/${usuario.id}";
    
    // Si se sube una imagen, utilizamos Multipart para enviar tanto los datos del usuario como la imagen
    if (imagePath != null && imagePath.isNotEmpty) {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['nombre'] = usuario.nombre;
      request.fields['apellido'] = usuario.apellido;
      request.fields['correo'] = usuario.correo;
      request.fields['numeroCelular'] = usuario.numeroCelular;
      request.fields['DNI'] = usuario.DNI;
      
      // Agregar la imagen como parte del cuerpo de la solicitud
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          final updatedUsuario = Usuario.fromJson(json.decode(responseBody));
          return updatedUsuario;
        } else {
          print('Error al actualizar el usuario!');
          return null;
        }
      } catch (e, stackTrace) {
        print('Error no esperado: $e');
        print(stackTrace);
        return null;
      }
    } else {
      // Si no hay imagen, enviamos los datos con PUT directamente
      try {
        var response = await http.put(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "nombre": usuario.nombre,
            "apellido": usuario.apellido,
            "correo": usuario.correo,
            "numeroCelular": usuario.numeroCelular,
            "DNI": usuario.DNI,
          }),
        );

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          final updatedUsuario = Usuario.fromJson(responseBody);
          return updatedUsuario;
        } else {
          print('Error al actualizar el usuario!');
          return null;
        }
      } catch (e) {
        print('Error no esperado: $e');
        return null;
      }
    }
  }

Future<Usuario?> register(
    String nombre,
    String apellido,
    String correo,
    String dni,
    String numeroCelular,
    String contrasena,
    DateTime fechaNacimiento,
    String rol, {
    String? especialidad,  // Parámetro opcional
  }) async {
    String url = "${BASE_URL}usuarios";  // Ruta para crear un usuario

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nombre": nombre,
          "apellido": apellido,
          "correo": correo,
          "DNI": dni,
          "NumCelular": numeroCelular,
          "contrasena": contrasena,
          "fecha_nacimiento": fechaNacimiento.toIso8601String(),
          "rol": rol,
          if (especialidad != null) "especialidad": especialidad,  // Enviar especialidad solo si es psicólogo
        }),
      );

      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        return Usuario.fromJson(responseBody);
      } else {
        print('Error de registro: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error inesperado: $e');
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
