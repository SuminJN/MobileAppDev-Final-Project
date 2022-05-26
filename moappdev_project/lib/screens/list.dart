import 'package:flutter/material.dart';

class Subject {
  Color color;
  String subjectName;
  String explanation;
  int credit;

  Subject(this.color, this.subjectName, this.explanation, this.credit);
}

class SubjectTile extends StatelessWidget {
  SubjectTile(this._subject);

  final Subject _subject;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration:
            BoxDecoration(color: _subject.color, shape: BoxShape.circle),
      ),
      title: Text(
        _subject.subjectName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(_subject.explanation),
      trailing: Text("${_subject.credit}학점"),
    );
  }
}

List<Color> subjectColor = [
  Colors.redAccent,
  Colors.lightBlueAccent,
  Colors.purpleAccent,
  Colors.greenAccent,
];

List<String> subjectName = [
  'Logic Design',
  'Mobile App Dev',
  'Algorithm',
  'Linear Algebra',
];

List<String> subjectExplanation = [
  'Explanation',
  'Explanation',
  'Explanation',
  'Explanation',
];

List<int> subjectCredit = [
  3,
  4,
  3,
  2,
];

List<Subject> subjectData = List.generate(
    subjectName.length,
    (index) => Subject(subjectColor[index], subjectName[index],
        subjectExplanation[index], subjectCredit[index]));

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);

  @override
  Widget build(BuildContext context) {
    void flutterDialog() {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: const <Widget>[
                  Text("Add Subject"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Explanation',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
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
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
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
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: subjectData.length,
        itemBuilder: (BuildContext context, int index) {
          return SubjectTile(subjectData[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 2,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () => flutterDialog(),
      ),
    );
  }
}
