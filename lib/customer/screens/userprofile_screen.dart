import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = 'user-profile-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
    );
  }
}
