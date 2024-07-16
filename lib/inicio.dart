import 'package:flutter/material.dart';

// ignore: camel_case_types
class inicio extends StatefulWidget {
  const inicio({super.key});

  @override
  State<inicio> createState() => _inicioState();
}

// ignore: camel_case_types
class _inicioState extends State<inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 96, 218, 63),   
      body: ListView.builder(
        itemCount: Menus.length + 3, // Dos tarjetas adicionales
        itemBuilder: (context, index) {
          if (index == 0) {
            // Tarjeta adicional 1
            return SizedBox(height: 30);
          } else if (index == 1) {
            // Tarjeta adicional 2
            return Column(children: [
              Container(
                child: Title(
                  color: Colors.black,
                  child: const Text(
                    "Bienvenido",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize:
                          24.0, // Adjust font size here (e.g., 16, 18, 20)
                    ),
                  ),
                ),
              )
            ]);
          } else if (index == 2) {
            // Tarjeta adicional 2
            return Column(
              children: [
                Title(
                  color: Colors.black,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0), // Add padding to sides
                    child: Text(
                      "Disfruta de esta gran varidad de platos que ofrecemos",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold, // Center the text
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            // Tarjetas de eventos existentes
            final eventoIndex = index - 3;
            return Card(
              child: Column(
                children: [
                  Image.asset(Menus[eventoIndex].imagen),
                  ListTile(
                    subtitle: Text(
                      "${Menus[eventoIndex].titulo}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 370,
                    child: Text(
                      '${Menus[eventoIndex].descripcion} \nLugar: ${Menus[eventoIndex].lugar}',
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class Menu {
  final int id;
  final String titulo;
  final String lugar;
  final String descripcion;
  final String imagen;

  Menu({
    required this.id,
    required this.titulo,
    required this.lugar,
    required this.descripcion,
    required this.imagen,
  });
}

final List<Menu> Menus = [
  Menu(
    id: 1,
    titulo: 'Seco de pollo',
    lugar: "Doña Marta",
    descripcion: 'Seco de pollo con verduras',
    imagen: 'img/seco.jpeg',
  ),
  Menu(
    id: 2,
    titulo: 'Bolones ',
    lugar: "Don Sebas",
    descripcion: 'Bolones de queso, chicharron y mixtos',
    imagen: 'img/seco.jpeg',
  ),
  Menu(
    id: 3,
    titulo: 'Sanduches',
    lugar: "Doña Clara",
    descripcion: 'Sanduches, de pollo, pernil, jamon, etc',
    imagen: 'img/seco.jpeg',
  ) // Agrega más Menus aquí
];
