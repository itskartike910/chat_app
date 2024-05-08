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
     const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 119, 254, 236),
        child: const Center(
          child: Text(
            "Welcome To The ChatBox",
             style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}
