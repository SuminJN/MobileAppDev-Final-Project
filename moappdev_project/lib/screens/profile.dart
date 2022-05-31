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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: appColor,
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: UserProfileAvatar(
                avatarUrl: 'https://picsum.photos/id/237/5000/5000',
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
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Name', style: TextStyle(fontWeight: FontWeight.bold),),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 40.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Minsu Kim',
                  ),
                ),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Major', style: TextStyle(fontWeight: FontWeight.bold),),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 40.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Computer Science',
                  ),
                ),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Semester', style: TextStyle(fontWeight: FontWeight.bold),),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 40.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '6th',
                  ),
                ),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Status', style: TextStyle(fontWeight: FontWeight.bold),),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 40.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'It\'s to hard to beat a person who never give up',
                  ),
                ),
              ),
            ),
            const Divider(thickness: 2,),
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 300,
            ),
          ],
        ),

    );
  }
}
