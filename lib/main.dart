import 'package:app_ohmyfuel/pg_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 253, 158, 14),
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shadowColor: Colors.black,
            elevation: 5,
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 253, 158, 14),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 253, 133, 14),
          shadowColor: Colors.black,
          elevation: 5,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
