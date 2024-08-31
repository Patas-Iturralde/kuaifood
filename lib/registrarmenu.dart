import 'package:flutter/material.dart';

class RegistrarMenu extends StatefulWidget {
  @override
  _RegistrarMenuState createState() => _RegistrarMenuState();
}

class _RegistrarMenuState extends State<RegistrarMenu> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

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
                        // Aquí puedes agregar la lógica para guardar el menú
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Menú registrado exitosamente')),
                        );
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
