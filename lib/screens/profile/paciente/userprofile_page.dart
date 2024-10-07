import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/models/entities/Usuario.dart';
import 'package:ulimagym/screens/profile/paciente/edituserprofile.dart';

class UsuarioProfilePage extends StatefulWidget {
  final Usuario usuario;

  const UsuarioProfilePage({Key? key, required this.usuario}) : super(key: key);

  @override
  _UsuarioProfilePageState createState() => _UsuarioProfilePageState();
}

class _UsuarioProfilePageState extends State<UsuarioProfilePage> {
  late Usuario usuario; // Para mantener los datos actualizados del usuario

  @override
  void initState() {
    super.initState();
    usuario = widget.usuario; // Inicializar con los datos actuales
  }

  void _navigateAndEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(usuario: usuario),
      ),
    );

    if (result != null && result is Usuario) {
      // Actualizar los datos del usuario con los nuevos datos
      setState(() {
        usuario = result; // Recibe el usuario actualizado y refresca la vista
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF112244), // Fondo azul oscuro
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF112244), // Fondo azul oscuro
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true, // Centrar carita sonriente
        title: Icon(
          Icons.sentiment_satisfied_alt, // Carita sonriente
          color: Colors.white,
          size: 28,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: _navigateAndEditProfile, // Llamar al método de edición
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.white, // Línea divisora blanca
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            // Imagen de perfil centrada y de mayor tamaño
            Stack(
              children: [
                CircleAvatar(
                  radius: 60, // Tamaño más grande para la imagen de perfil
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/44.jpg'), // Puedes cambiar la imagen aquí
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      // Implementar acción de tomar o seleccionar foto
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Nombre del usuario, más grande y centrado
            Text(
              '${usuario.nombre} ${usuario.apellido}', // Cambiado para incluir nombre y apellido
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // DNI del usuario
            Text(
              "DNI",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              usuario.DNI,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Correo electrónico
            Text(
              "Correo electrónico",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              usuario.correo,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Número de celular
            Text(
              "Número de celular",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              usuario.numeroCelular,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
