import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moappdve_project/screens/setting.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  final _nameController = TextEditingController();
  final _majorController = TextEditingController();
  final _semesterController = TextEditingController();
  final _statusController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? _name;
  String? _major;
  int? _semester;
  String? _status;
  String? _photoUrl;

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: appColor,
      ),
      body: FutureBuilder(
          future: readData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.connectionState != ConnectionState.done
                ? const Center(child: CircularProgressIndicator())
            : ListView(
              children: <Widget>[
                ListTile(
                  title: UserProfileAvatar(
                    avatarUrl: _photoUrl!,
                    onAvatarTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tapped on avatar'),
                        ),
                      );
                    },
                    avatarSplashColor: Colors.purple,
                    radius: 100,
                    isActivityIndicatorSmall: false,
                    avatarBorderData: AvatarBorderData(
                      borderColor: Colors.black54,
                      borderWidth: 5.0,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 40.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: _name,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Text(
                    'Major',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 40.0),
                    child: TextFormField(
                      controller: _majorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: _major,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Text(
                    'Semester',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 40.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _semesterController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: _semester.toString(),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: const Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 40.0),
                    child: TextFormField(
                      controller: _statusController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: _status,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          editInfo();
                          Navigator.pop(context);
                        },
                        child: const Text('Edit'),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
              ],
            );
          }),
    );
  }

  Future<void> editInfo() async {
    var user = FirebaseFirestore.instance.collection('user')
        .doc(_firebaseAuth.currentUser!.uid);

    user.set({
      'name': _nameController.text == '' ? _name : _nameController.text,
      'major': _majorController.text == '' ? _major : _majorController.text,
      'semester': _semesterController.text == '' ? _semester : int.parse(_semesterController.text),
      'status': _statusController.text == '' ? _status : _statusController.text,
    });
  }

  Future<void> readData() async {
    final userInfo = FirebaseFirestore.instance
        .collection('user')
        .doc(_firebaseAuth.currentUser!.uid);

    await userInfo.get().then((value) => {
          _name = value.data()!['name'],
          _major = value.data()!['major'],
          _semester = value.data()!['semester'],
          _status = value.data()!['status'],
          _photoUrl = value.data()!['photoUrl'],
        });
  }
}
