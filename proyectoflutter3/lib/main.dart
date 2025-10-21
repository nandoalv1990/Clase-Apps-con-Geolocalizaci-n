import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraCompletaApp());
}

class CalculadoraCompletaApp extends StatelessWidget {
  const CalculadoraCompletaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraUI() ,
    );
  }
}
class CalculadoraUI extends StatefulWidget {
  const CalculadoraUI({super.key});

  @override
  State<CalculadoraUI> createState() => _CalculadoraUIState();
}

class _CalculadoraUIState extends State<CalculadoraUI> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String resultado = "0";

  void calcular(String operacion){
    double a = double.tryParse(num1Controller.text) ?? 0;
    double b = double.tryParse(num2Controller.text) ?? 0;
    double res;
    switch (operacion){
      case '+':
      res = a + b;
      break;
      case '-':
      res = a - b;
      break;
      case '*':
      res = a * b;
      break;
      case '/':
      res = b != 0 ? a / b: double.nan;
      break;
      default:
      res = 0;
    }
    setState(() {
      resultado = res.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora completa'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campos de entrada
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: num1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Primer digito',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: num2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Segundo digito',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Filas de botones (layouts)
            Row(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () => calcular('+'), 
                    icon: Icon(Icons.add)
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }
}