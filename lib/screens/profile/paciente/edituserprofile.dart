import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/services/user_service.dart';
import 'package:psicoapp/widgets/changepassword_dialog.dart';

class EditProfilePage extends StatefulWidget {
  final Usuario usuario;

  EditProfilePage({required this.usuario});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController rolController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los datos actuales del usuario
    nombreController.text = widget.usuario.nombre;
    apellidoController.text = widget.usuario.apellido;
    dniController.text = widget.usuario.DNI;
    correoController.text = widget.usuario.correo;
    celularController.text = widget.usuario.numeroCelular;
    rolController.text = widget.usuario.rol;
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Crear una instancia de Usuario con los datos actualizados
      Usuario updatedUser = Usuario(
        id: widget.usuario.id,
        nombre: nombreController.text,
        apellido: apellidoController.text,
        correo: correoController.text,
        DNI: dniController.text,
        numeroCelular: celularController.text,
        contrasena: widget.usuario.contrasena, // Mantener la contraseña
        fechaNacimiento: widget.usuario.fechaNacimiento,
        rol: rolController.text,
      );

      // Actualizar el usuario llamando al servicio
      var updatedUsuario = await UserService().updateUsuario(updatedUser);

      if (updatedUsuario != null) {
        if (mounted) {
          Navigator.pop(context, updatedUsuario); // Regresar con el usuario actualizado
          Get.snackbar('Éxito', 'Perfil actualizado correctamente');
        }
      } else {
        if (mounted) {
          Get.snackbar('Error', 'Hubo un problema al actualizar el perfil');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProfile, // Llamar a _saveProfile para guardar los cambios
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: apellidoController,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un apellido válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: dniController,
                decoration: InputDecoration(labelText: 'DNI'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un DNI válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Por favor ingresa un correo válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: celularController,
                decoration: InputDecoration(labelText: 'Número de Celular'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un número de celular válido';
                  }
                  return null;
                },
              ),
              // Botón para abrir el diálogo de cambio de contraseña
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Cambiar Contraseña'),
                onPressed: () {
                  // Abrir el diálogo de cambio de contraseña
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ChangePasswordDialog(usuario: widget.usuario);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
