import 'package:flutter/material.dart';
import 'package:kuaifood/crearlocal.dart';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/login.dart';

class crearCuenta extends StatefulWidget {
  const crearCuenta({super.key});

  @override
  State<crearCuenta> createState() => _crearCuentaState();
}

class _crearCuentaState extends State<crearCuenta> {
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
                    const SizedBox(
                      height: 50,
                      width: 400,
                    ),
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Nombre', // Add your header text here
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
                            labelText: 'Apellido', // Add your header text here
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
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText:
                                'Numero celular', // Add your header text here
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
                        child: Text('Crear usuario'),
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
                        "¿Ya tienes una cuenta? Inicia sesión",
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => crearLocal()));
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
