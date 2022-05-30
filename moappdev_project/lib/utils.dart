import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Example event class.
class Event {
  final String title;

  Event(this.title);

  @override
  String toString() => title;
}

// List<Map<DateTime, List<Event>>> plans = [];
Map<DateTime, List<Event>> plans = {};

Future<void> getPlans() async {
  FirebaseFirestore.instance.collection('plan').snapshots().listen((snapshot) {
    // plans = {};
    for (final document in snapshot.docs) {
      plans[document.data()['date'].toDate()] = [Event(document.data()['title'])];
    }
  });
  print(plans);
}

final events = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(plans);

Map<DateTime, List<Event>> eventSource = {
  DateTime(2022, 5, 3): [Event('testTitle')],
  DateTime(2022, 5, 17): [Event('testTitle')],
  DateTime(2022, 5, 29): [Event('testTitle')],
};

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({});

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
