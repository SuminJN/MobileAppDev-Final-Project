import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          style: const TextStyle(color: Colors.black),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => flutterDialog(),
                    child: const Text('Add Plan'),
                  ),
                ],
              ),
              const Divider(
                thickness: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  CollectionReference plan = FirebaseFirestore.instance.collection('plan');
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();

  void flutterDialog() {
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
                  height: 10,
                ),
                ElevatedButton(
                  child: Text('Date'),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
                Text('결과: $currentDate'),
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
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      plan.add(<String, dynamic>{
                        'title': _titleController.text,
                        'date': DateTime.now(),
                      });
                      _titleController.clear();
                      _dateController.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
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
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }
}
