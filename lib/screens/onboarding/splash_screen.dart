import 'package:flutter/material.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 900), () {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 96, color: Colors.white),
            SizedBox(height: 12),
            Text('N1 Projeto', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Organize suas tarefas com simplicidade', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
