import 'package:flutter/material.dart';
import 'package:crud_mobile_flutter/screen/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/home';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initialFunction();
    super.initState();
  }

  initialFunction() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacementNamed(MainScreen.routeName, arguments: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Image.asset('assets/icons/logo.png', fit: BoxFit.cover, height: 30),
      ),
    );
  }
}
