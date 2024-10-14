import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/Usuario.dart';
import 'package:psicoapp/services/user_service.dart';

class ChangePasswordDialog extends StatefulWidget {
  final Usuario usuario;

  ChangePasswordDialog({required this.usuario});

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController contrasenaActualController = TextEditingController();
  final TextEditingController nuevaContrasenaController = TextEditingController();
  final TextEditingController confirmarContrasenaController = TextEditingController();

  void _cambiarContrasena() async {
    if (_formKey.currentState!.validate()) {
      // Verificar que las contraseñas coincidan
      if (nuevaContrasenaController.text != confirmarContrasenaController.text) {
        Get.snackbar('Error', 'Las contraseñas no coinciden');
        return;
      }

      // Realizar la solicitud al backend para cambiar la contraseña
      bool success = await UserService().cambiarContrasena(
        widget.usuario.id,
        contrasenaActualController.text,
        nuevaContrasenaController.text,
      );

      if (success) {
        Get.snackbar('Éxito', 'Contraseña actualizada correctamente');
        Navigator.pop(context); // Cerrar el modal
      } else {
        Get.snackbar('Error', 'Contraseña actual incorrecta');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cambiar Contraseña'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: contrasenaActualController,
              decoration: InputDecoration(labelText: 'Contraseña Actual'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la contraseña actual';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nuevaContrasenaController,
              decoration: InputDecoration(labelText: 'Nueva Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la nueva contraseña';
                }
                return null;
              },
            ),
            TextFormField(
              controller: confirmarContrasenaController,
              decoration: InputDecoration(labelText: 'Confirmar Nueva Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor confirma la nueva contraseña';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context); // Cerrar el modal sin hacer nada
          },
        ),
        TextButton(
          child: Text('Guardar'),
          onPressed: _cambiarContrasena, // Llamar al método para cambiar la contraseña
        ),
      ],
    );
  }
}
