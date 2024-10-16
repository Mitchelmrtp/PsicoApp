import 'package:flutter/material.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/screens/profile/paciente/edituserprofile.dart';

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

      setState(() {
        usuario = result; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF112244), 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF112244),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true, 
        title: Icon(
          Icons.sentiment_satisfied_alt, 
          color: Colors.white,
          size: 28,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: _navigateAndEditProfile,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.white, 
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 60, 
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/44.jpg'), 
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              '${usuario.nombre} ${usuario.apellido}', 
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

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
