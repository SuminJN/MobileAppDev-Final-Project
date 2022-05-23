import 'package:flutter/material.dart';

import 'home.dart';
import 'signin.dart';
import 'login.dart';

class HanplApp extends StatelessWidget {
  const HanplApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hanpl',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}


