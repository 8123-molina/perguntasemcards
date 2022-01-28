import 'package:flutter/material.dart';
import 'package:perguntasemcards/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/preload',
      routes: {
        '/login' : (_) => const LoginPage(title:'Login');
        '/register' : (_) => const RegisterPage(title:'Register');
        '/home' : (_) => const HomePage(title:'Home');
        '/cards' : (_) => const CardsPage(title:'cards');
        '/favoritos' : (_) => const FavoritosPage(title:'Favorit');
      },
    );
  }
}
