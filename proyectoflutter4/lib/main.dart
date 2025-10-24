import 'package:flutter/material.dart';

void main() {
  runApp(const AppLayout() );
}

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  static const controllers = [
    Text(
      "AC",
      style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    Text(
      "()",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    Text(
      "%",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    Text(
      "÷",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "7",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "8",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "9",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "X",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "4",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "5",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "6",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "+",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "1",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "2",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "3",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      ".",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
     Text(
      "0",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    Icon(
      Icons.backspace_rounded,
      color: Colors.white,
    ),
     Text(
      "=",
     style: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 156, 37, 180),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.black,
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child:,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
