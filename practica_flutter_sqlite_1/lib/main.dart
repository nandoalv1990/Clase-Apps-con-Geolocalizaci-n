import 'package:flutter/material.dart';
import 'src/init_screen.dart';
import 'theme/app_theme.dart';// Sin provider


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode mode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      mode = mode == ThemeMode.light? ThemeMode.dark : ThemeMode.light;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      home: InitScreen(
        onToggleTheme: toggleTheme,
      ),
    );
  }
}
