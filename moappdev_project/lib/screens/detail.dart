import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chart/line_chart_page.dart';
import 'chart/line_chart_sample1.dart';
import 'chart/line_chart_sample2.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.document}) : super(key: key);
  final DocumentSnapshot<Object?> document;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  final User? user = FirebaseAuth.instance.currentUser;
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.document.data()! as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['title'],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () async {
              QuerySnapshot querySnap = await FirebaseFirestore.instance
                  .collection('subject')
                  .where('title', isEqualTo: data['title'])
                  .get();
              QueryDocumentSnapshot doc = querySnap.docs[0];
              FirebaseFirestore.instance
                  .collection('subject')
                  .doc(doc.id)
                  .delete();
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => flutterDialog(data['title']),
                  child: const Text('Add Plan'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo.shade300,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(height: 20,),
            LineChartSample2(),
            const SizedBox(height: 20,),
            LineChartSample1(),
          ],
        ),
      ),
    );
  }

  CollectionReference plan = FirebaseFirestore.instance.collection('plan');
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();

  void flutterDialog(String subjectName) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: const <Widget>[
                Text("Add Plan"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Date'),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _titleController.clear();
                      _dateController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      plan.add(<String, dynamic>{
                        'title': _titleController.text,
                        'date': currentDate,
                        'userId': user?.uid.toString(),
                        'isAchieved': false,
                        'subject': subjectName,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _titleController.text + ' is added',
                            style: const TextStyle(fontSize: 15),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                      );

                      _titleController.clear();
                      _dateController.clear();
                      currentDate = DateTime.now();
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }
}
