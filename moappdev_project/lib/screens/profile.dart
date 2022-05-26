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
        body: Center(
          child: UserProfileAvatar(
            avatarUrl: 'https://picsum.photos/id/237/5000/5000',
            onAvatarTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tapped on avatar'),
                ),
              );
            },
            notificationCount: 10,
            notificationBubbleTextStyle: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            avatarSplashColor: Colors.purple,
            radius: 100,
            isActivityIndicatorSmall: false,
            avatarBorderData: AvatarBorderData(
              borderColor: Colors.black54,
              borderWidth: 5.0,
            ),
          ),
        ),
    );
  }
}
