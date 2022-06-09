import 'package:flutter/material.dart';
import 'package:moappdve_project/screens/stopwatch.dart';
import 'package:moappdve_project/screens/translator.dart';

class FunctionPage extends StatefulWidget {
  const FunctionPage({Key? key}) : super(key: key);

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StopwatchPage()));
              },
              child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.redAccent.shade200.withOpacity(0.6), Colors.redAccent.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(width: 3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  'assets/images/stopwatch.png',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TranslatorPage()));
              },
              child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orangeAccent.shade200.withOpacity(0.6), Colors.orangeAccent.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(width: 3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  'assets/images/translator.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
