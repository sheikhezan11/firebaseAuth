import 'package:firebaseauth/Auth/splash_loader_animator.dart';
import 'package:firebaseauth/Root/root.dart';
import 'package:firebaseauth/controller/UserController/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {

    userController = Provider.of<UserController>(context, listen:  false);
    if (userController.currentUser.uid == null) {
      return FutureBuilder(
          future: userController.checkUserSigninInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              // root Functionality
              return Root();
            } else {
              return SplashLoaderAnimator();
            }
          });
    } else {
      // root Functionality
      return Root();
    }
  }
}
