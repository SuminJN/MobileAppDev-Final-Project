import 'package:flutter/material.dart';
import 'package:moappdve_project/screens/calendar/calendar.dart';
import 'package:moappdve_project/screens/function.dart';
import 'package:moappdve_project/screens/subject.dart';
import 'package:moappdve_project/screens/profile.dart';
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

  final List<Widget> _titles = [const Text('Home'), const Text('Function'), const Text('Subject'), const Text('Setting')];
  final List<Widget> _pages = [CalendarPage(), const FunctionPage(), const SubjectPage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_selectedIndex],
        backgroundColor: appColor,
      ),
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
            icon: Icon(Icons.apps),
            label: 'Function',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Subject',
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
