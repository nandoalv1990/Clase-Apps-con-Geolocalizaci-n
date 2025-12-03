import 'package:flutter/material.dart';
import 'src/splash_page.dart';
import 'config/app_config.dart';

void main() async {
  // (API keys, etc.) config/app_config.json
  await AppConfig.instance.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage()
    );
  }
}
