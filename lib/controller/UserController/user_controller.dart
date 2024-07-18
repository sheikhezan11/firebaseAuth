import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/model/my_user.dart';
import 'package:firebaseauth/services/user_database.dart';
import 'package:flutter/foundation.dart';

class UserController with ChangeNotifier {

  MyUser currentUser = MyUser();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> registerUser(String e, String p) async {

    MyUser user = MyUser();

    try{

      UserCredential authResult = await auth.createUserWithEmailAndPassword(email: e, password: p);
      UserCredential LoginResult = await auth.signInWithEmailAndPassword(email: e, password: p);

      if(authResult.user!=null){
        print("User Added to Database");
        user.uid = authResult.user!.uid;
        user.password = p;
         user.email = authResult.user!.email;

        UserDatabase().createUserInDatabase(user);

      }

      return true;

    } catch(e) {
      print(e);
      return false;
    }
  }

  Future<bool> LoginUser(String e, String p) async {
    try {
      UserCredential loginResult = await auth.signInWithEmailAndPassword(email: e, password: p);
      if (loginResult.user != null) {
        UserDatabase().getUserInfoById(loginResult.user!.uid);
        return true; // Login successful
      }
    } catch (e) {
      print(e);
    }
    return false; // Login failed
  }


  Future<bool> SignOut() async {
    try{
      await auth.signOut();
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  void setCurrentUser(MyUser user){
    currentUser = user;
    notifyListeners();
  }

  Future<MyUser> checkUserSigninInfo() async {
    try{
      MyUser myUser = MyUser();
      myUser.isLoadingStartupData = true;
      currentUser = myUser;
      auth.authStateChanges().listen((event)async {

        if(event?.uid == null ){
          myUser.uid = null;
          myUser.isLoadingStartupData = false;
          setCurrentUser(myUser);


        } else {
          myUser.uid = event?.uid;
          myUser = await UserDatabase().getUserInfoById(auth.currentUser!.uid);
          setCurrentUser(myUser);
        }

      }
      );
      if (kDebugMode) {
        print(myUser.uid);
      }

      return myUser;
    } catch(e){
      print(e);
      return MyUser();
    }

  }



}
