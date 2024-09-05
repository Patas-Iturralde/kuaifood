import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kuaifood/registrarmenu.dart'; // Para manejar JSON

class inicio extends StatefulWidget {
  final bool esRestaurante; // Determina si es un restaurante

  const inicio({super.key, required this.esRestaurante});

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  List<Menu> menus = [];
  bool isLoading = true; // Estado de carga

  @override
  void initState() {
    super.initState();
    fetchMenus(); // Llamamos a la función para obtener los menús
  }

  // Función para obtener la fecha de hoy en formato "YYYY-MM-DD"
  String getCurrentDate() {
    final DateTime now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  // Función para obtener los menús de la API
  Future<void> fetchMenus() async {
    setState(() {
      isLoading = true; // Activar estado de carga
    });

    final String fechaHoy = getCurrentDate(); // Obtener la fecha actual
    final url = Uri.parse('http://10.0.2.2:3000/menu?fecha=$fechaHoy'); // URL con la fecha actual como parámetro

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body); // Imprime la respuesta de la API para verificar

        // Decodifica la respuesta JSON
        final List<dynamic> data = json.decode(response.body);

        // Mapea los datos obtenidos en la lista de menús
        setState(() {
          menus = data.map((menuData) {
            return Menu(
              id: menuData['id'],
              numeroAlmuerzos: menuData['numero_almuerzos'],
              sopas: menuData['sopas'],
              platoFuerte: menuData['plato_fuerte'],
              postres: menuData['postres'],
              jugos: menuData['jugos'],
              ensaladas: menuData['ensaladas'],
              extras: menuData['extras'],
              fecha: menuData['fecha'],
            );
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Error al obtener los menús');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Función para reducir el número de almuerzos y actualizar en la base de datos
  Future<void> restarAlmuerzos(int menuId, int numeroAlmuerzos) async {
    if (numeroAlmuerzos > 0) {
      final url = Uri.parse('http://10.0.2.2:3000/menu/$menuId');
      
      try {
        final response = await http.put(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"numero_almuerzos": numeroAlmuerzos - 1}),
        );

        if (response.statusCode == 200) {
          // Actualizar la lista de menús en la interfaz
          setState(() {
            menus.firstWhere((menu) => menu.id == menuId).numeroAlmuerzos--;
          });
        } else {
          throw Exception('Error al actualizar el número de almuerzos');
        }
      } catch (e) {
        print('Error de conexión: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 96, 218, 63),
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Color.fromRGBO(2, 110, 95, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchMenus, // Llamar a la función para actualizar
            tooltip: 'Actualizar menús',
          ),
        ],
      ),
      // Mostrar el Drawer solo si es restaurante
      drawer: widget.esRestaurante
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(2, 110, 95, 1),
                    ),
                    child: Text(
                      'Menú',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.restaurant_menu),
                    title: Text('Registrar Menú'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrarMenu()),
                      );
                    },
                  ),
                ],
              ),
            )
          : null, // Si no es restaurante, no mostramos el Drawer
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Indicador de carga
          : menus.isEmpty
              ? Center(child: Text('No hay menús disponibles para hoy')) // Mensaje si no hay menús
              : ListView.builder(
                  itemCount: menus.length + 3, // Dos tarjetas adicionales
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox(height: 30);
                    } else if (index == 1) {
                      return Column(children: [
                        Container(
                          child: Title(
                            color: Colors.black,
                            child: const Text(
                              "Bienvenido",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        )
                      ]);
                    } else if (index == 2) {
                      return Column(
                        children: [
                          Title(
                            color: Colors.black,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "Disfruta de esta gran variedad de platos que ofrecemos",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      // Tarjetas de menús obtenidos desde la API
                      final menuIndex = index - 3;
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              subtitle: Text(
                                "Plato Fuerte: ${menus[menuIndex].platoFuerte}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 370,
                              child: Text(
                                'Sopa: ${menus[menuIndex].sopas} \n'
                                'Postres: ${menus[menuIndex].postres} \n'
                                'Jugos: ${menus[menuIndex].jugos} \n'
                                'Ensaladas: ${menus[menuIndex].ensaladas} \n'
                                'Extras: ${menus[menuIndex].extras} \n'
                                'Número de almuerzos: ${menus[menuIndex].numeroAlmuerzos} \n'
                                'Fecha: ${menus[menuIndex].fecha}',
                                style: TextStyle(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Mostrar los almuerzos disponibles
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Disponibles: ${menus[menuIndex].numeroAlmuerzos}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                // Botón para restar almuerzos
                                ElevatedButton(
                                  onPressed: () {
                                    restarAlmuerzos(menus[menuIndex].id, menus[menuIndex].numeroAlmuerzos);
                                  },
                                  child: Text('Reservar almuerzo'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 74, 207, 33), // Color del botón
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
    );
  }
}

// Clase Menu para manejar los menús
class Menu {
  final int id;
  int numeroAlmuerzos; // Convertido a variable mutable
  final String sopas;
  final String platoFuerte;
  final String postres;
  final String jugos;
  final String ensaladas;
  final String extras;
  final String fecha;

  Menu({
    required this.id,
    required this.numeroAlmuerzos,
    required this.sopas,
    required this.platoFuerte,
    required this.postres,
    required this.jugos,
    required this.ensaladas,
    required this.extras,
    required this.fecha,
  });
}
