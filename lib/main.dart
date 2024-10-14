import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa Provider
import 'package:psicoapp/screens/Quest/quest_controller.dart';
import 'screens/Auth/Login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CuestionarioController()), // Añade el CuestionarioController aquí
        // Si tienes otros controladores, los añades aquí de manera similar
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        home: LoginPage(), // Página de inicio
      ),
    );
  }
}
