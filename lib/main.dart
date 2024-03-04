import 'package:flutter/material.dart';
import 'package:reliable/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reliable Services',
      home: SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
