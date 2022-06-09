import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final User? user = FirebaseAuth.instance.currentUser;
Stream planStream = FirebaseFirestore.instance.collection('plan').snapshots();

class Event {
  final String title;
  bool isAchieved;
  final String docId;
  final String subject;

  Event(this.title, this.isAchieved, this.docId, this.subject);

  @override
  String toString() => title;
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageExampleState createState() => _CalendarPageExampleState();
}

class _CalendarPageExampleState extends State<CalendarPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  late CalendarController _controller;
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: planStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              {
                _events = {};
                for (final document in snapshot.data!.docs) {
                  if (user?.uid.toString() == document.data()['userId']) {
                    if (_events.containsKey(document.data()['date'].toDate())) {
                      _events[document.data()['date'].toDate()]!.add(Event(
                        document.data()['title'],
                        document.data()['isAchieved'],
                        document.id,
                        document.data()['subject'],
                      ));
                    } else {
                      _events[document.data()['date'].toDate()] = [
                        Event(
                          document.data()['title'],
                          document.data()['isAchieved'],
                          document.id,
                          document.data()['subject'],
                        )
                      ];
                    }
                  }
                }
              }

              return Column(
                children: [
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        canEventMarkersOverflow: true,
                        todayColor: Colors.grey,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle:
                          const TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onDaySelected: (date, events, holydays) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade300,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  const SizedBox(height: 8.0),
                  ..._selectedEvents.map(
                    (event) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: event.isAchieved == false
                            ? Colors.redAccent.shade100
                            : Colors.lightBlue.shade300,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          checkIsAchieved(event);
                          setState(() {
                            event.isAchieved == false
                                ? event.isAchieved = true
                                : event.isAchieved = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 700),
                              content: Text(
                                event.isAchieved == false
                                    ? 'Cancelled.'
                                    : 'Accomplished!!!',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              backgroundColor: event.isAchieved == false
                                  ? Colors.redAccent.shade100
                                  : Colors.lightBlue.shade300,
                            ),
                          );
                        },
                        title: Text(
                          event.subject + ' - ' + event.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Future<void> checkIsAchieved(Event event) async {
    final userInfo =
        FirebaseFirestore.instance.collection('plan').doc(event.docId);

    userInfo.update({
      'isAchieved': event.isAchieved == false ? true : false,
    });
  }
}
