import 'package:chat_app/widgets/consts.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget.child!),
            (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: gradientBackground,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.whatshot,
                size: 100,
                color: Colors.black87,
              ),
              Text(
                "Welcome To The ChatBox",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}
