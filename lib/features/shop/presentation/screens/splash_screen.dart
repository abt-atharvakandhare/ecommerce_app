import 'dart:async';
import 'package:flutter/material.dart';
import 'product_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ProductCatalogScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'E-Commerce App',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'CustomFont',
                fontFamilyFallback: <String>[
                  'Helvetica Neue',
                ],
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}