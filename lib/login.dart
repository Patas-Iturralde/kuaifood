import 'package:flutter/material.dart';
import 'package:kuaifood/crearlocal.dart';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/login.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 96, 218, 63),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
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
                    const SizedBox(
                      height: 50,
                      width: 400,
                    ),
                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 400,
                    ),
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
                    const SizedBox(
                      height: 50,
                      width: 400,
                    ),
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Email', // Add your header text here
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              // Border when focused
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(
                                      2, 110, 95, 1)), // Set your desired color
                            ),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(2, 110, 95, 1))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText:
                                'Contraseña', // Add your header text here
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              // Border when focused
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(
                                      2, 110, 95, 1)), // Set your desired color
                            ),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(2, 110, 95, 1))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => inicio()));
                        },
                        child: Text('Iniciar sesión'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(2, 110, 95, 1)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                        print("Texto clickeado");
                      },
                      child: const Text(
                        "¿No tienes una cuenta? Crear una nueva",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => crearLocal()));
                        print("Texto clickeado");
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
