import 'dart:async';
import 'package:flutter/material.dart';
import 'product_screen.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key});

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {

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
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.check_circle_outline,
              size: 70,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Thank You for Shopping!!!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
                letterSpacing: 1.2,
                fontFamily: 'CustomFont',
                fontFamilyFallback: <String>[
                  'Helvetica Neue',
                ],
              ),
            ),
            Text(
              'Your Order has been placed successfully.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                letterSpacing: 1.2,
                fontFamily: 'CustomFont',
                fontFamilyFallback: <String>[
                  'Helvetica Neue',
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}
