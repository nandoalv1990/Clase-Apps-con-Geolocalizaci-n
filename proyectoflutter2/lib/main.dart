import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraSumaApp());
}


class CalculadoraSumaApp extends StatelessWidget {
  @override 

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora básica',
      home: CalculadoraUI(),
    );
  }
}

class CalculadoraUI extends StatefulWidget {
  @override
  _CalculadoraUIState createState() => _CalculadoraUIState();
}

class _CalculadoraUIState extends State<CalculadoraUI> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  double resultado = 0;

  void sumar(){
    setState(() { 
      double a = double.tryParse(num1Controller.text) ?? 0;
      double b = double.tryParse(num2Controller.text) ?? 0;
      resultado = a + b;
    });
  }
  @override 
  widget @override
  Widget build(BuildContext context) {
    return ;
  }
}