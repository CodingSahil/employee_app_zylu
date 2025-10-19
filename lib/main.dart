import 'package:employee_app_zylu/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://tjyqbqcbbudxiysjgrgv.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqeXFicWNiYnVkeGl5c2pncmd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIwNTk3MDUsImV4cCI6MjA1NzYzNTcwNX0.BClQVd_elhS8hCxMn8VP6fTS5wdnJV_XV46kKCd8vx4",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App Zylu',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
