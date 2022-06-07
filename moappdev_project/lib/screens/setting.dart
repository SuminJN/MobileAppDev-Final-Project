import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moappdve_project/login.dart';
import 'package:moappdve_project/screens/profile.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream userStream = FirebaseFirestore.instance.collection('user').snapshots();

  String? _name;
  String? _major;
  int? _semester;
  String? _status;

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: UserProfileAvatar(
                    avatarUrl: 'https://picsum.photos/id/237/5000/5000',
                    onAvatarTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tapped on avatar'),
                        ),
                      );
                    },
                    avatarSplashColor: Colors.purple,
                    radius: 40,
                    isActivityIndicatorSmall: false,
                    avatarBorderData: AvatarBorderData(
                      borderColor: Colors.black54,
                      borderWidth: 5.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                FutureBuilder(
                    future: readData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.connectionState != ConnectionState.done
                          ? const CircularProgressIndicator()
                          : Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(_status!),
                                ],
                              ),
                            );
                    }),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            const ListTile(
              leading: Icon(
                Icons.person,
                size: 40,
              ),
              title: Text(
                'Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Privacy, security'),
            ),
            const Divider(
              thickness: 2,
            ),
            const ListTile(
              leading: Icon(
                Icons.notifications_none,
                size: 40,
              ),
              title: Text(
                'Nofitications',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Message, group & call tones'),
            ),
            const Divider(
              thickness: 2,
            ),
            const ListTile(
              leading: Icon(
                Icons.headset_mic_outlined,
                size: 40,
              ),
              title: Text(
                'Help',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Help cenre, contact us, privacy policy'),
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
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
        });
  }
}
