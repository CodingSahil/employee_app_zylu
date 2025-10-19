import 'package:employee_app_zylu/views/home_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeView();
            },
          ),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)),
            SizedBox(height: 4),
            Text(
              "Welcome to App!!",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
