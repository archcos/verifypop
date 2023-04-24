import 'package:flutter/material.dart';
import 'package:flutter_laravel/screens/home_screen.dart';
import 'package:flutter_laravel/services/auth.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Quality Detection System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}