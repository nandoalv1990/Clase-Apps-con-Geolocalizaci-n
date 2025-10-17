import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  String mensaje = "Bienvenido A Flutter";

  void CambiarMensaje(){
    setState(() {
      mensaje = "Has precionado el botón";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mi primera interfaz UI"),
      backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensaje, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), 
            Image.network('https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png', 
            width: 120,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: CambiarMensaje, child: Text("Cambiar mensaje"),
            ),
          ],
        ),
      ),
    );
  }
}

