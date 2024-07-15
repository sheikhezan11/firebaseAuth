import 'package:firebaseauth/model/signout_model.dart';
import 'package:firebaseauth/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatelessWidget {
  final User? user; // Assuming you pass the logged-in user as a parameter

  const HomeView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Logged-in User: ${user?.email ?? "No user logged in"}',
                style: TextStyle(fontSize: 18.0),
              ),
              RoundButton(title: 'SignOut',
                  onTap: () => SignoutModel.signOut(context)),
            ],
          ),
        ),
      ),
    );
  }
}
