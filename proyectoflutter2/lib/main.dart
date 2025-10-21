import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraSumaApp());
}


class CalculadoraSumaApp extends StatelessWidget {
  const CalculadoraSumaApp({super.key});

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
  const CalculadoraUI({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suma con layouts'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(padding: const EdgeInsets.all(20.0),
      child: Column(
        // Layout principal: organización vertical
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Calculadora básica',
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Row(
            // Layout secundario: organiza horizontalmente los TextFields
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  controller: num1Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número 1',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(child: TextField(
                controller: num2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número 2',
                  border: OutlineInputBorder(),
                ),
              ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.green,
                size: 30.0,
              ),
              SizedBox(width: 10.0,),
              ElevatedButton(
                onPressed: sumar, 
               child: Text('sumar'),
          ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Resultado: $resultado',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
      ),
    );
  }
}