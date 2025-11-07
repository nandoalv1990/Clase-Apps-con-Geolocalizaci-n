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
        _calculateResult();
      }
    });
  }

  void _calculateResult(){
     String expression = _input.replaceAll("X", "*").replaceAll("÷", "/");
     ExpressionParser p = GrammarParser();
    try {
     Expression exp = p.parse(expression);
     var cm = ContextModel();
     var evaluator = RealEvaluator(cm);
     num eval = evaluator.evaluate(exp);
     _output = eval.toString();
    } catch (e) {
      _output = "";
    }
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
              flex: 7,
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
                        fontSize: 60.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _output,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Botones
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0
                  ),
                  itemBuilder: (context, index){
                    final text = buttons[index];
                    final isOperator = ["÷", "X", "-", "+", "="].contains(text);
                    final isSpecial = ["AC", "⌫", "%", "()"].contains(text);
                    Color bgColor = isOperator? const Color.fromARGB(255, 255, 0, 255) : (isSpecial? const Color(0xff5f726c): const Color.fromARGB(255, 25, 25, 25));
                    return ElevatedButton(
                      onPressed: () => _onButtonPressed(text), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Text(
                        text, // Este se usa en _CalculateResult()
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}