import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/screens/CHATIO/chatwid.dart';
import 'package:psicoapp/screens/Quest/quest_page.dart';
import 'package:psicoapp/screens/Solicitar_Cita/Solicitar_Cita_page.dart';
import 'package:psicoapp/screens/Home/Home_Paciente/prueba.dart';
import 'package:psicoapp/screens/profile/psicologo/doctor_page.dart';
import 'package:psicoapp/screens/profile/paciente/userprofile_page.dart';
import 'homepaciente_controller.dart';

class ContactSpecialistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF112244), // Fondo azul oscuro
      appBar: AppBar(
        elevation: 0, // Sin sombra
        backgroundColor: Color(0xFF112244), // Fondo del AppBar igual al fondo
        automaticallyImplyLeading: true, // Mostrar el ícono de retroceso
        centerTitle: true, // Centrar el ícono
        title: Icon(
          Icons.sentiment_satisfied_alt, // Ícono de la carita
          color: Colors.white,
          size: 28,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/44.jpg'), // Imagen de perfil
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Estás a punto de contactar a un especialista en salud mental',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40), // Espacio entre el texto y los botones
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Fondo verde
                foregroundColor: Colors.white, // Texto blanco
                minimumSize: Size(200, 50), // Tamaño del botón
              ),
              onPressed: () {
                // Acción al confirmar
                print("Confirmar contacto con especialista");
              },
              child: Text('CONFIRMAR'),
            ),
            SizedBox(height: 20), // Espacio entre los botones
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Fondo rojo
                foregroundColor: Colors.white, // Texto blanco
                minimumSize: Size(200, 50), // Tamaño del botón
              ),
              onPressed: () {
                // Regresar a la pantalla anterior
                Navigator.pop(context);
              },
              child: Text('CANCELAR'),
            ),
          ],
        ),
      ),
    );
  }
}


class HomePacientePage extends StatefulWidget {
  final Usuario usuarioLogged;

  const HomePacientePage({Key? key, required this.usuarioLogged}) : super(key: key);

  @override
  _HomePacientePageState createState() => _HomePacientePageState(usuarioLogged: usuarioLogged);
}

class _HomePacientePageState extends State<HomePacientePage> {
  final Usuario usuarioLogged;
  HomePacienteController control = Get.put(HomePacienteController());
  int _selectedIndex = 0;

  late String roomId;
  late String userId;

  late final List<Widget> _widgetOptions;

  bool _notificationsEnabled = true;
  bool _agendaEnabled = false;
  bool _monitoringEnabled = true;

  _HomePacientePageState({required this.usuarioLogged});

  @override
  void initState() {
    super.initState();
    userId = usuarioLogged.id.toString(); // Establece el userId basado en el usuario autenticado.
    roomId = 'chat_${usuarioLogged.id}';  // Genera un roomId único.

    // Definir las pantallas a mostrar en el BottomNavigationBar
    _widgetOptions = [
      SolicitarCitaPage(usuarioLogged),
      QuestPage(), // Página de cuestionario
      UsuarioProfilePage(usuario: usuarioLogged), // Perfil del usuario logueado
      DoctorProfilePage(doctorId: usuarioLogged.id) // Se asume que el id del usuario es el del doctor en este caso
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Crear el Drawer (menú lateral)
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Color(0xFF112244), // Color de fondo del Drawer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20), // Espacio en la parte superior
            // ExpansionTile para Notificaciones
            ExpansionTile(
              leading: Icon(Icons.notifications, color: Colors.white),
              title: Text('Notificaciones', style: TextStyle(color: Colors.white)),
              children: <Widget>[
                ListTile(
                  title: Text('Activar Notificaciones', style: TextStyle(color: Colors.white)),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  subtitle: Text(_notificationsEnabled ? 'Activado' : 'Desactivado', style: TextStyle(color: Colors.grey)),
                ),
                ListTile(
                  title: Text('Tono de notificación', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
                  subtitle: Text('Latido de corazón', style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // Implementar la selección de tono
                  },
                ),
                ListTile(
                  title: Text('Agenda', style: TextStyle(color: Colors.white)),
                  trailing: Switch(
                    value: _agendaEnabled,
                    onChanged: (value) {
                      setState(() {
                        _agendaEnabled = value;
                      });
                    },
                  ),
                  subtitle: Text(_agendaEnabled ? 'Activado' : 'Desactivado', style: TextStyle(color: Colors.grey)),
                ),
                ListTile(
                  title: Text('Monitoreo emocional', style: TextStyle(color: Colors.white)),
                  trailing: Switch(
                    value: _monitoringEnabled,
                    onChanged: (value) {
                      setState(() {
                        _monitoringEnabled = value;
                      });
                    },
                  ),
                  subtitle: Text(_monitoringEnabled ? 'Activado' : 'Desactivado', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            Divider(color: Colors.white24, thickness: 1), // Línea divisora
            ListTile(
              leading: Icon(Icons.security, color: Colors.white),
              title: Text('Seguridad', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Acción al pulsar
              },
            ),
            Divider(color: Colors.white24, thickness: 1), // Línea divisora
            ListTile(
              leading: Icon(Icons.article, color: Colors.white),
              title: Text('Términos y condiciones', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Acción al pulsar
              },
            ),
            Divider(color: Colors.white24, thickness: 1), // Línea divisora
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Colors.white),
              title: Text('Política de privacidad', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Acción al pulsar
              },
            ),
            Divider(color: Colors.white24, thickness: 1), // Línea divisora
            ListTile(
              leading: Icon(Icons.error_outline, color: Colors.white),
              title: Text('Informar de un error', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Acción al pulsar
              },
            ),
            Spacer(), // Empuja el contenido hacia arriba para dejar espacio
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Fondo rojo para el botón
                  foregroundColor: Colors.white, // Texto en blanco
                  minimumSize: Size(double.infinity, 50), // Tamaño ancho completo
                ),
                onPressed: () {
                  // Redirigir a la pantalla de confirmación
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactSpecialistPage(),
                    ),
                  );
                },
                child: Text('Contacta a un especialista'),
              ),
            ),
            SizedBox(height: 20), // Espacio debajo del botón
            Center(
              child: TextButton(
                onPressed: () {
                  // Redirigir a la pantalla de inicio de sesión
                  control.goToLogIn(context);
                },
                child: Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20), // Espacio adicional para que quede alineado
          ],
        ),
      ),
    );
  }

  // Actualizar los iconos del BottomNavigationBar
  Widget _navigationBottom() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border), // Ícono de estrella
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera_outlined), // Ícono de cámara
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline), // Ícono de chat
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), // Ícono de perfil
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0XFFF26F29), // Color seleccionado
      unselectedItemColor: Colors.black, // Color de los íconos no seleccionados
      backgroundColor: Colors.white, // Fondo blanco
      showSelectedLabels: false, // Sin etiquetas
      showUnselectedLabels: false, // Sin etiquetas
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0, // Sin sombra
        backgroundColor: Colors.white, // Fondo blanco para el AppBar
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(), // Abre el Drawer
          ),
        ),
        centerTitle: true, // Carita sonriente centrada
        title: Icon(
          Icons.sentiment_satisfied_alt, // Ícono de carita sonriente
          color: Colors.black,
          size: 28, // Tamaño ajustado al mockup
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              print("Abrir notificaciones");
            },
          ),
          // Dentro de las acciones en AppBar
          GestureDetector(
            onTap: () {
              // Al hacer clic en la imagen, ir al perfil del usuario
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsuarioProfilePage(usuario: usuarioLogged), // Pasar los datos del usuario
                ),
              );
            },
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/44.jpg', // URL de la imagen de perfil
              ),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(), // Drawer como menú lateral
      body: _widgetOptions.elementAt(_selectedIndex), // Contenido del body
      bottomNavigationBar: _navigationBottom(), // Barra de navegación inferior
    );
  }
}
