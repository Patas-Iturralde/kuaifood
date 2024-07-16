import 'package:flutter/material.dart';
import 'package:kuaifood/crearcuenta.dart';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/login.dart';

class crearLocal extends StatefulWidget {
  const crearLocal({super.key});

  @override
  State<crearLocal> createState() => _crearLocalState();
}

class _crearLocalState extends State<crearLocal> {
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime2;

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _selectTime2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime2) {
      setState(() {
        _selectedTime2 = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 110, 95, 1),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Nuevo Local",
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
                          labelText: 'Nombre del local',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(2, 110, 95, 1),
                            ),
                          ),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 26,
                        ),
                        SizedBox(
                          width: 140,
                          child: GestureDetector(
                            onTap: () => _selectTime(context),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _selectedTime == null
                                      ? 'Hora apertura'
                                      : '${_selectedTime?.format(context)}',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(2, 110, 95, 1),
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(2, 110, 95, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 140,
                          child: GestureDetector(
                            onTap: () => _selectTime2(context),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _selectedTime == null
                                      ? 'Hora cierre'
                                      : '${_selectedTime2?.format(context)}',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(2, 110, 95, 1),
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(2, 110, 95, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(2, 110, 95, 1),
                            ),
                          ),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(2, 110, 95, 1),
                            ),
                          ),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Numero celular',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(2, 110, 95, 1),
                            ),
                          ),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => inicio()),
                        );
                      },
                      child: Text('Crear local'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 96, 218, 63),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => crearCuenta()),
                        );
                        print("Texto clickeado");
                      },
                      child: const Text(
                        "¿Eres un nuevo cliente? Crea una cuenta de cliente",
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
