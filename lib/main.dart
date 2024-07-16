import 'package:flutter/material.dart';
import 'package:kuaifood/appbienvenida.dart';
import 'package:kuaifood/inicio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "inicio",
          routes: {
            "inicio": (context) => const appbienvenida(),
            "login": (context) => const inicio(),
          });
  }
}
