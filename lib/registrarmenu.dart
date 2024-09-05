import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar JSON

class RegistrarMenu extends StatefulWidget {
  @override
  _RegistrarMenuState createState() => _RegistrarMenuState();
}

class _RegistrarMenuState extends State<RegistrarMenu> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TextEditingController _sopaController = TextEditingController();
  TextEditingController _platoFuerteController = TextEditingController();
  TextEditingController _postreController = TextEditingController();
  TextEditingController _jugoController = TextEditingController();
  TextEditingController _ensaladaController = TextEditingController();
  TextEditingController _extraController = TextEditingController();
  TextEditingController _numeroAlmuerzosController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _registrarMenu() async {
    final url = Uri.parse('http://10.0.2.2:3000/menu');
// Cambia con la IP correcta

    // Los datos que se enviarán al API
    final body = {
  "sopas": _sopaController.text, // Cambiado de 'sopa' a 'sopas'
  "plato_fuerte": _platoFuerteController.text,
  "postres": _postreController.text, // Cambiado de 'postre' a 'postres'
  "jugos": _jugoController.text, // Cambiado de 'jugo' a 'jugos'
  "ensaladas": _ensaladaController.text, // Cambiado de 'ensalada' a 'ensaladas'
  "extras": _extraController.text, // Cambiado de 'extra1' a 'extras'
  "numero_almuerzos": int.tryParse(_numeroAlmuerzosController.text) ?? 0,
  "fecha": _selectedDate?.toIso8601String(), // Envía la fecha en formato ISO
};


    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body), // Codifica el cuerpo de la petición en JSON
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Menú registrado exitosamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar el menú')),
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
      backgroundColor: Color.fromRGBO(2, 110, 95, 1),
      appBar: AppBar(
        title: Text('Registrar Menú'),
        backgroundColor: Color.fromRGBO(2, 110, 95, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _sopaController,
                    decoration: InputDecoration(
                      labelText: 'Sopa',
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _platoFuerteController,
                    decoration: InputDecoration(
                      labelText: 'Plato Fuerte',
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _postreController,
                    decoration: InputDecoration(
                      labelText: 'Postre',
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _jugoController,
                    decoration: InputDecoration(
                      labelText: 'Jugo',
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _ensaladaController,
                    decoration: InputDecoration(
                      labelText: 'Ensalada',
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _extraController,
                    decoration: InputDecoration(
                      labelText: 'Extras',
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _numeroAlmuerzosController,
                    decoration: InputDecoration(
                      labelText: 'Número de Disponibilidad',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(2, 110, 95, 1),
                        ),
                      ),
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: _selectedDate == null
                              ? 'Fecha del Menú'
                              : '${_selectedDate?.toLocal()}'.split(' ')[0],
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
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _registrarMenu();  // Llamada a la función que hace la petición al API
                      }
                    },
                    child: Text('Registrar Menú'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 96, 218, 63),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
