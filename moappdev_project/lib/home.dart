import 'package:flutter/material.dart';
import 'package:moappdve_project/screens/homehome.dart';
import 'package:moappdve_project/screens/list.dart';
import 'package:moappdve_project/screens/setting.dart';
import 'package:moappdve_project/screens/stopwatch.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  int _selectedIndex = 0;

  final List<Widget> _pages = [const HomeHomePage(), const StopwatchPage(), const ListPage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: appColor,
        selectedItemColor: Colors.black,
        selectedFontSize: 14,
        unselectedItemColor: Colors.blueGrey,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Stopwatch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
