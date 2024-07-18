import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/model/my_user.dart';
import 'package:firebaseauth/services/user_database.dart';

class UserController {

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
    try{
      UserCredential loginResult =
      await auth.signInWithEmailAndPassword(email: e, password: p);
      if(loginResult.user !=null ){

        UserDatabase().getUserInfoById(loginResult.user!.uid);
      }
    }catch(e){

    }


    return false;
  }
}
