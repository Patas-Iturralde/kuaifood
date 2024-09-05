import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kuaifood/inicio.dart'; // Página principal después del login
import 'package:kuaifood/crearlocal.dart'; // Página para crear locales
import 'package:kuaifood/crearcuenta.dart'; // Página para crear cuentas de clientes

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  // Controladores para capturar los datos del formulario
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();

  // Función para enviar el formulario de inicio de sesión
  Future<void> iniciarSesion() async {
    final url = Uri.parse('http://10.0.2.2:3000/login'); // URL de la API

    // Datos a enviar
    final body = {
      "correo": correoController.text,
      "contrasenia": contraseniaController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Decodificar la respuesta
        final data = json.decode(response.body);
        final String mensaje = data['mensaje'];

        // Redirigir según el tipo de usuario
        if (mensaje == "cliente") {
          // Redirigir a la pantalla de cliente
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => inicio(esRestaurante: false,)), // Página principal para cliente
          );
        } else if (mensaje == "restaurante") {
          // Redirigir a la pantalla de restaurante
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => inicio(esRestaurante: true,)), // Página principal para restaurante
          );
        }
      } else {
        // Mostrar mensaje de error si las credenciales no son válidas
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales inválidas')),
        );
      }
    } catch (e) {
      // Mostrar error si hay problemas de conexión
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 96, 218, 63),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Iniciar sesión",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const SizedBox(height: 50, width: 400),
                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 20, width: 400),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        "Inicia sesión para disfrutar de tu almuerzo favorito de manera rápida y sencilla.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50, width: 400),
                    // Campo para el correo
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: correoController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo para la contraseña
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: contraseniaController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                        obscureText: true, // Para ocultar la contraseña
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Botón para iniciar sesión
                    ElevatedButton(
                      onPressed: iniciarSesion, // Llamar a la función iniciarSesion
                      child: Text('Iniciar sesión'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(2, 110, 95, 1)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Navegación a otras pantallas
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => crearCuenta()),
                        );
                      },
                      child: const Text(
                        "¿No tienes una cuenta? Crear una nueva",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => crearLocal()),
                        );
                      },
                      child: const Text(
                        "¿Tienes un local? Crea una cuenta de negocio",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
