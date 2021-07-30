import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taranga_app/services/auth.dart';
import 'package:taranga_app/shared/color.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);
  // context.watch<UserModel>().email

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            // size: 35,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(user!.email.toString()),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                dynamic res = await _auth.signOut();
                print('return from res is $res');
                if (res == null) {
                  Navigator.pop(context);
                }
              },
              child: Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
