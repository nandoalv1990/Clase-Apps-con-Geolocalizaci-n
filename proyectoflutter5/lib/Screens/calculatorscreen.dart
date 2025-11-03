import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "";

  final List<String> buttons = [
    "AC", "()", "%", "÷",
    "7","8","9","X",
    "4","5","6","-",
    "1","2","3","+",
    "0",".","⌫","="
  ];

  void _onButtonPressed(String text){
    setState(() {
      if (text == "AC"){
        _input = "";
        _output = "";
      }else if (text == "⌫"){
        if(_input.isNotEmpty){
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (text == "="){
        _calculateResult();
      } else {
        _input += text;
      }
    });
  }

  void _calculateResult(){
    String expression = _input.replaceAll("X", "*").replaceAll("÷", "/");
   /*try {
      // ignore: deprecated_member_use
      ShuntingYardParser p = Parser(expression);
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(type, context)
    } catch (e) {
      _output = "ERROR de SYNTX";
    }*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Pantalla de resultados
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}