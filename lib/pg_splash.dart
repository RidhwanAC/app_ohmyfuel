import 'package:app_ohmyfuel/pg_home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late double pgWidth;
  late double pgHeight;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    pgWidth = MediaQuery.of(context).size.width;
    pgHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 0.9 * pgWidth,
                height: 0.6 * pgHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/car.png',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0.12 * pgHeight,
                      child: Text(
                        'OhMyFuel',
                        style: TextStyle(
                          fontSize: 0.06 * pgHeight,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              width: 0.08 * pgHeight,
              height: 0.08 * pgHeight,
              child: CircularProgressIndicator(
                strokeWidth: 0.015 * pgHeight,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 0.02 * pgHeight),
            Text(
              'Loading...',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 0.03 * pgHeight,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
