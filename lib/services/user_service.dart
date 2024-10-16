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

   Future<Usuario?> updateUsuario(Usuario usuario) async {
    String url = "${BASE_URL}usuarios/${usuario.id}";

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return Usuario.fromJson(responseBody);
      } else {
        print('Error al actualizar el usuario');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }

  
Future<bool> cambiarContrasena(int idUsuario, String contrasenaActual, String nuevaContrasena) async {
  String url = "${BASE_URL}usuarios/$idUsuario/cambiar-contrasena";

  try {
    var response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contrasenaActual": contrasenaActual,  // Contraseña actual enviada al backend
        "nuevaContrasena": nuevaContrasena  // Nueva contraseña enviada al backend
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Contraseña actualizada correctamente');
      return true;
    } else if (response.statusCode == 400) {
      print('Error: Contraseña actual incorrecta');
      return false;
    } else {
      print('Error al cambiar la contraseña: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error inesperado: $e');
    return false;
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
    String? especialidad,  
  }) async {
    String url = "${BASE_URL}usuarios";  

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
          if (especialidad != null) "especialidad": especialidad,  
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

  Future<String?> recuperarContrasena(String dni, String correo) async {
  String url = "${BASE_URL}usuarios/recuperar-contrasena";  

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "dni": dni,
        "correo": correo,
      }),
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      return responseBody['contrasena']; 
    } else {
      print('Error al recuperar la contraseña: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error inesperado: $e');
    return null;
  }
}


  Future<List<Usuario>?> getPacientesByPsicologo(int psicologoId) async {
    String url = "${BASE_URL}psicologo/$psicologoId/pacientes";

    try {
      var response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        List<dynamic> responseBody = json.decode(response.body);
        List<Usuario> pacientes = responseBody.map((json) => Usuario.fromJson(json)).toList();
        return pacientes;
      } else {
        print('Error al obtener pacientes: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error inesperado: $e');
      return null;
    }
  }
}
