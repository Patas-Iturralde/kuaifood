import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kuaifood/crearlocal.dart';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/login.dart';

class crearCuenta extends StatefulWidget {
  const crearCuenta({super.key});

  @override
  State<crearCuenta> createState() => _crearCuentaState();
}

class _crearCuentaState extends State<crearCuenta> {
  // Controladores para los campos del formulario
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();

  // Función para crear un nuevo usuario
  Future<void> crearUsuario() async {
    final url = Uri.parse('http://10.0.2.2:3000/clientes'); // Asegúrate de que esta URL sea correcta

    // Datos a enviar
    final body = {
      "cedula": cedulaController.text,
      "nombre": nombreController.text,
      "apellido": apellidoController.text,
      "correo": correoController.text,
      "contrasenia": contraseniaController.text,
      "telefono": telefonoController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario creado exitosamente')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => inicio(esRestaurante: false,)), // Redirigir a la página de inicio
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el usuario')),
        );
      }
    } catch (e) {
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
                "Nuevo Cliente",
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
                    const SizedBox(height: 30),
                    // Campo Cédula
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: cedulaController,
                        decoration: InputDecoration(
                          labelText: 'Cédula',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo Nombre
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo Apellido
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: apellidoController,
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo Email
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: correoController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo Contraseña
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: contraseniaController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                        obscureText: true, // Para ocultar el texto
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Campo Número Celular
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: telefonoController,
                        decoration: InputDecoration(
                          labelText: 'Número Celular',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle: TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Botón Crear Usuario
                    ElevatedButton(
                      onPressed: crearUsuario,
                      child: Text('Crear usuario'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(2, 110, 95, 1)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                      },
                      child: const Text(
                        "¿Ya tienes una cuenta? Inicia sesión",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => crearLocal()));
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
              )
            ],
          )
        ],
      ),
    );
  }
}
