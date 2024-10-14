import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/services/user_service.dart';


class HomeControllerPsicologo extends GetxController {
  var pacientes = <Usuario>[].obs;
  UserService userService = UserService();

  // Cargar la lista de pacientes del psicólogo
  void loadPacientes(int psicologoId) async {
    try {
      List<Usuario>? result = await userService.getPacientesByPsicologo(psicologoId);
      if (result != null) {
        pacientes.assignAll(result);
      } else {
        pacientes.clear();
      }
    } catch (e) {
      print('Error al cargar pacientes: $e');
    }
  }
}
