import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/Auth/splash_loader_animator.dart';
import 'package:firebaseauth/controller/UserController/user_controller.dart';
import 'package:firebaseauth/view/home_view.dart';
import 'package:firebaseauth/view/login_view.dart';
import 'package:firebaseauth/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  firstTime,
  authenticating,
  notLoggedIn,
  loggedInHome,
  noProfile,
  noFriend,
}

class Root extends StatelessWidget {
  AuthStatus authStatus = AuthStatus.authenticating;

  @override
  Widget build(BuildContext context) {
    UserController userController = Provider.of<UserController>(context, listen: true);

    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        if (userController.currentUser.uid == null) {
          authStatus = AuthStatus.notLoggedIn;
        } else if (userController.currentUser.displayName == null) {
          authStatus = AuthStatus.noProfile;
        } else {
          authStatus = AuthStatus.loggedInHome;
        }
        switch (authStatus) {
          case AuthStatus.authenticating:
            return SplashLoaderAnimator();
          case AuthStatus.noProfile:
            return SignupView();
          case AuthStatus.notLoggedIn:
            return LoginView();
          default:
            return HomeView(user: FirebaseAuth.instance.currentUser);
        }
      },
    );
  }
}
