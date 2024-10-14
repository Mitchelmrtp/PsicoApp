import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/screens/CHATIO/chatwid.dart';
import 'package:psicoapp/screens/Sesion/Sesion_page.dart';
import 'homepsicologo_controller.dart';

class HomePsicologoPage extends StatefulWidget {
  final Usuario usuarioLogged;

  const HomePsicologoPage({Key? key, required this.usuarioLogged}) : super(key: key);

  @override
  _HomePsicologoPageState createState() => _HomePsicologoPageState(usuarioLogged: usuarioLogged);
}

class _HomePsicologoPageState extends State<HomePsicologoPage> {
  final Usuario usuarioLogged;
  HomeControllerPsicologo control = Get.put(HomeControllerPsicologo());
  int _selectedIndex = 0;

  late String userId;

  _HomePsicologoPageState({required this.usuarioLogged});

  @override
  void initState() {
    super.initState();
    userId = usuarioLogged.id.toString(); // Establecemos el userId del psicólogo
    control.loadPacientes(usuarioLogged.id); // Cargamos los pacientes del psicólogo
  }

  // Cambiar de pantalla en el BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          // Si aún está cargando pacientes, mostrar un texto de carga
          if (control.pacientes.isEmpty) {
            return Text("Cargando sesiones...");
          } else {
            // Si ya se cargaron los pacientes, mostrar el número de sesiones
            return Text("Sesiones: ${control.pacientes.length}");
          }
        }),
      ),
      body: Obx(() {
        if (control.pacientes.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: control.pacientes.length,
            itemBuilder: (context, index) {
              final paciente = control.pacientes[index];
              return ListTile(
                title: Text('${paciente.nombre} ${paciente.apellido}'),
                subtitle: Text('ID Paciente: ${paciente.id}'),
                trailing: Icon(Icons.chat),
                onTap: () {
                  final String roomId = 'chat_${usuarioLogged.id}_${paciente.id}';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(roomId: roomId, userId: userId),
                    ),
                  );
                },
                onLongPress: () {
                  // Redirige a la página de completar sesión
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SesionPage(
                        pacienteId: paciente.id,
                        psicologoId: usuarioLogged.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
