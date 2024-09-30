import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/models/entities/UserChat.dart';
import 'package:ulimagym/models/entities/Usuario.dart';
import 'package:ulimagym/pages/chatdata/chat_page.dart';
import 'package:ulimagym/pages/exercise/exercise_page.dart';
import 'package:ulimagym/pages/pantalla_inicio/inicio_initial_p.dart';
import 'package:ulimagym/pages/routine/routine_page.dart';
import 'home_controller.dart';

// Pantalla de confirmación para contactar a un especialista
class ContactSpecialistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF112244),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF112244),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Icon(
          Icons.sentiment_satisfied_alt,
          color: Colors.white,
          size: 28,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
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
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
              onPressed: () {
                print("Confirmar contacto con especialista");
              },
              child: Text('CONFIRMAR'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
              onPressed: () {
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

class HomePage extends StatefulWidget {
  final Usuario usuarioLogged;

  const HomePage({Key? key, required this.usuarioLogged}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user: usuarioLogged);
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());
  int _selectedIndex = 0;
  Usuario user;

  // Aquí creamos el `conversationId` y el `UserChat` necesario para ChatPage
  final int conversationId = 1;
  final UserChat userChat;

  late final List<Widget> _widgetOptions;

  bool _notificationsEnabled = true;
  bool _agendaEnabled = false;
  bool _monitoringEnabled = true;

  _HomePageState({required this.user})
      : userChat = UserChat(
          id: user.id,
          username: user.usuario,
          createdAt: DateTime.now().toString(),
        ) {
    _widgetOptions = [
      RoutinePage(user),  // Página de rutinas
      ExercisePage(),  // Página de ejercicios
      ChatPage(conversationId: conversationId, userChat: userChat),  // Página de chat
      PantallaDeInicioInitialPage(),  // Página de inicio
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
        color: Color(0xFF112244),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
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
              ],
            ),
            Divider(color: Colors.white24, thickness: 1),
            ListTile(
              leading: Icon(Icons.security, color: Colors.white),
              title: Text('Seguridad', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Acción de seguridad
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactSpecialistPage(),
                    ),
                  );
                },
                child: Text('Contactar a un especialista'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  control.goToLogIn(context);
                },
                child: Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Icono de notificaciones en el AppBar
  Widget _notificationIcon() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
            print("Abrir notificaciones");
          },
        ),
        Positioned(
          right: 11,
          top: 11,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  // Icono de perfil en el AppBar
  Widget _profileIcon() {
    return GestureDetector(
      onTap: () {
        print("Perfil del usuario");
      },
      child: CircleAvatar(
        radius: 15,
        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
      ),
    );
  }

  // Carita sonriente en el centro del AppBar
  Widget _smileIcon() {
    return Icon(
      Icons.sentiment_satisfied_alt,
      color: Colors.black,
      size: 28,
    );
  }

  // Barra de navegación inferior
  Widget _navigationBottom() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0XFFF26F29),
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          centerTitle: true,
          title: _smileIcon(),
          actions: [
            _notificationIcon(),
            _profileIcon(),
          ],
        ),
        drawer: _buildDrawer(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: _navigationBottom(),
      ),
    );
  }
}
