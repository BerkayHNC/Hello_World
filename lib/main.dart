import 'package:flutter/material.dart';
import 'package:hello_world/login.dart';

void main() {
  
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Berkays App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 153, 0)
        ),
        useMaterial3: true,
      ),

      home: LoginPage(),
    );
  }
}

//const Placeholder();