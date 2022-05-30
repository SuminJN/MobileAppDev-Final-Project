import 'package:flutter/material.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              leading: Text('Name'),
              title: Text('Minsu Kim'),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Major'),
              title: Text('Computer Science'),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Semester'),
              title: Text('6th'),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: Text('Status'),
              title: Text('It\'s hard to beat a person who never gives up'),
            ),
            const Divider(thickness: 2,),
            const SizedBox(
              height: 0,
            ),
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
