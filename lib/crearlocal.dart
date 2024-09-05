import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/login.dart';
import 'package:kuaifood/crearcuenta.dart';

class crearLocal extends StatefulWidget {
  const crearLocal({super.key});

  @override
  State<crearLocal> createState() => _crearLocalState();
}

class _crearLocalState extends State<crearLocal> {
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime2;

  // Controladores para capturar la información de los campos del formulario
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  bool metodoPagoEfectivo = false;
  bool metodoPagoTransferencia = false;
  bool metodoEntregaDomicilio = false;
  bool metodoEntregaLocal = false;

  // Función para seleccionar la hora de apertura
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

  // Función para seleccionar la hora de cierre
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

  // Función para crear un nuevo restaurante
  Future<void> crearLocal() async {
    final url = Uri.parse('http://10.0.2.2:3000/restaurantes'); // Cambia la URL si es necesario

    // Horario en formato string
    String horario = '${_selectedTime?.format(context)} - ${_selectedTime2?.format(context)}';

    // Verificar si los campos están vacíos o NULL
    if (nombreController.text.isEmpty ||
        correoController.text.isEmpty ||
        contraseniaController.text.isEmpty ||
        telefonoController.text.isEmpty ||
        _selectedTime == null ||
        _selectedTime2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return; // Salir de la función si hay campos vacíos
    }

    // Concatenar métodos de pago seleccionados
    String metodosPago = "";
    if (metodoPagoEfectivo) metodosPago += "Efectivo ";
    if (metodoPagoTransferencia) metodosPago += "Transferencia ";

    // Concatenar métodos de entrega seleccionados
    String metodosEntrega = "";
    if (metodoEntregaDomicilio) metodosEntrega += "Domicilio ";
    if (metodoEntregaLocal) metodosEntrega += "Local ";

    // Verificar si los métodos de pago o entrega están vacíos
    if (metodosPago.isEmpty || metodosEntrega.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona al menos un método de pago y un método de entrega')),
      );
      return; // Salir de la función si no se seleccionaron métodos de pago o entrega
    }

    // Datos a enviar
    final body = {
      "nombre": nombreController.text,
      "horario": horario,
      "metodos_pago": metodosPago.trim(), // Elimina espacios adicionales
      "metodos_entrega": metodosEntrega.trim(), // Elimina espacios adicionales
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
          SnackBar(content: Text('Restaurante registrado exitosamente')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => inicio(esRestaurante: true,)), // Redirigir a la página de inicio
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar el restaurante')),
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
                    // Campo para el nombre del local
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: nombreController,
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
                    // Campos para seleccionar horario de apertura y cierre
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
                                      color: Color.fromRGBO(2, 110, 95, 1)),
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
                                  labelText: _selectedTime2 == null
                                      ? 'Hora cierre'
                                      : '${_selectedTime2?.format(context)}',
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
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Campo para el email del local
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: correoController,
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
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                        obscureText: true,  // Para ocultar el texto de la contraseña
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Campo para el número celular
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: telefonoController,
                        decoration: InputDecoration(
                          labelText: 'Número celular',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(2, 110, 95, 1)),
                          ),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(2, 110, 95, 1)),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Métodos de pago
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Métodos de pago:"),
                        CheckboxListTile(
                          title: const Text("Efectivo"),
                          value: metodoPagoEfectivo,
                          onChanged: (value) {
                            setState(() {
                              metodoPagoEfectivo = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text("Transferencia"),
                          value: metodoPagoTransferencia,
                          onChanged: (value) {
                            setState(() {
                              metodoPagoTransferencia = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    // Métodos de entrega
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Métodos de entrega:"),
                        CheckboxListTile(
                          title: const Text("Domicilio"),
                          value: metodoEntregaDomicilio,
                          onChanged: (value) {
                            setState(() {
                              metodoEntregaDomicilio = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text("En el local"),
                          value: metodoEntregaLocal,
                          onChanged: (value) {
                            setState(() {
                              metodoEntregaLocal = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Botón para crear el local
                    ElevatedButton(
                      onPressed: crearLocal, // Llamada a la función crearLocal
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
                    // Navegación hacia otras pantallas
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
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
