import 'package:flutter/material.dart';

import 'home.dart';
import 'signin.dart';
import 'login.dart';

class HanplApp extends StatelessWidget {
  const HanplApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanpl',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signin': (context) => const SigninPage(),
      },
    );
  }
}


