import 'package:flutter/material.dart';
import 'package:kuaifood/crearcuenta.dart';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/login.dart';

class opcionInicio extends StatefulWidget {
  const opcionInicio({super.key});

  @override
  State<opcionInicio> createState() => _opcionInicioState();
}

class _opcionInicioState extends State<opcionInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 96, 218, 63),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('img/KuaiFoodLogo_Negativo.png'),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  },
                  child: Text('Iniciar sesión'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(2, 110, 95, 1)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => crearCuenta()));
                  },
                  child: Text('Crear usuario'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(2, 110, 95, 1)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  )),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            inicio(esRestaurante: false, sinSesion: true)),
                  );
                },
                child: Text('Continuar sin iniciar sesión'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 96, 218, 63)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
