import 'package:get/get.dart';
import 'package:ulimagym/models/entities/Usuario.dart';

class UsuarioProfileController extends GetxController {
  final Rx<Usuario> usuario;

  UsuarioProfileController(this.usuario);

  // Método para actualizar la información del perfil
  void updateProfile(String nombre, String apellido, String correo, String telefono, String? nuevaContrasena) {
    usuario.update((user) {
      user?.nombre = nombre;
      user?.apellido = apellido;
      user?.correo = correo;
      user?.numeroCelular = telefono;
      
      // Actualizar la contraseña solo si se proporciona una nueva
      if (nuevaContrasena != null && nuevaContrasena.isNotEmpty) {
        user?.contrasena = nuevaContrasena;
      }
    });
  }
}
