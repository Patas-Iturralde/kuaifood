import 'package:flutter/material.dart';
import 'package:kuaifood/inicio.dart';
import 'package:kuaifood/opcioninicio.dart';

class appbienvenida extends StatefulWidget {
  const appbienvenida({super.key});

  @override
  State<appbienvenida> createState() => _appbienvenidaState();
}

class _appbienvenidaState extends State<appbienvenida> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var d = const Duration(seconds: 5);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const opcionInicio()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.fromLTRB(40, 150, 30, 30),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
        begin: Alignment.topCenter,
      )),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('img/KuaiFoodLogo.png'),
              )
            ],
          ),
          const Divider(
            height: 50,
            color: Colors.transparent,
          ),
          const LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(0, 110, 95, 1),
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(75, 185, 45, 1)),
          ),
        ],
      ),
    )));
  }
}
