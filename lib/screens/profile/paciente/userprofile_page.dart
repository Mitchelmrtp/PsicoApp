import 'package:flutter/material.dart';
import 'package:ulimagym/models/entities/Usuario.dart';

class UserProfilePage extends StatelessWidget {
  final Usuario usuarioLogged;

  const UserProfilePage({Key? key, required this.usuarioLogged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre Completo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              usuarioLogged.nombreCompleto,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Correo Electrónico:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              usuarioLogged.correo,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Número de Celular:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              usuarioLogged.numeroCelular,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Tipo de Usuario:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              usuarioLogged.tipoUsuario,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'DNI:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              usuarioLogged.DNI,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            usuarioLogged.admin
                ? Text(
                    'Rol: Administrador',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  )
                : Text(
                    'Rol: Usuario Estándar',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
          ],
        ),
      ),
    );
  }
}
