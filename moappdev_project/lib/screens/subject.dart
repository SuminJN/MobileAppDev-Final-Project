import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moappdve_project/screens/detail.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  final User? user = FirebaseAuth.instance.currentUser;

  Stream subjectStream =
      FirebaseFirestore.instance.collection('subject').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: subjectStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                    children: snapshot.data!.docs
                        .map<Widget>((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return user!.uid.toString() == data['userId']
                      ? Card(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        document: document,
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['title'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data['explanation']),
                                      ],
                                    ),
                                  ),
                                  Text("${data['credit']}학점"),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
                }).toList()),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade300,
        child: const Icon(Icons.add),
        onPressed: () => flutterDialog(),
      ),
    );
  }

  CollectionReference subjects =
      FirebaseFirestore.instance.collection('subject');
  final _titleController = TextEditingController();
  final _explanationController = TextEditingController();
  final _creditController = TextEditingController();

  void flutterDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: const <Widget>[
                Text("Add Subject"),
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
                    labelText: 'Subject',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _explanationController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Explanation',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _creditController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Credit',
                  ),
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
                      _explanationController.clear();
                      _creditController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      subjects.add(<String, dynamic>{
                        'title': _titleController.text,
                        'explanation': _explanationController.text,
                        'credit': int.parse(_creditController.text),
                        'userId': user!.uid,
                      });
                      _titleController.clear();
                      _explanationController.clear();
                      _creditController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Check'),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
