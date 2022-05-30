import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moappdve_project/screens/detail.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
              return ListView(
                  children: snapshot.data!.docs
                      .map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                  return user!.uid.toString() == data['userId']
                    ? Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(document: document,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            //Color 설정
                            // Container(
                            //   width: 40,
                            //   height: 40,
                            //   decoration:
                            //       BoxDecoration(color: _subject.color, shape: BoxShape.circle),
                            // ),
                            // const SizedBox(
                            //   width: 15,
                            // ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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

              }).toList());
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () => flutterDialog(),
      ),
    );
  }

  CollectionReference subjects = FirebaseFirestore.instance.collection('subject');
  final _titleController = TextEditingController();
  final _explanationController = TextEditingController();
  final _creditController = TextEditingController();

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
                    child: Text('Cancel'),
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
                    child: Text('Check'),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
