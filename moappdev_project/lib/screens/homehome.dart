import 'package:flutter/material.dart';

class HomeHomePage extends StatefulWidget {
  const HomeHomePage({Key? key}) : super(key: key);

  @override
  _HomeHomePageState createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<HomeHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is Home Page'),
      ),
    );
  }
}
