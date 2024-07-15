import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauth/model/my_user.dart';

class UserDatabase {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> createUserInDatabase(MyUser user) async {
    try{
      await firestore.collection("user").doc(user.uid).set({
        "uid": user.uid,
        "password": user.password,
        "email": user.email,
        "avatarUrl" : user.avatarUrl,
        "accountCreated": Timestamp.now(),
        "gender": user.gender,
        "phone": user.phone,
        "displayName" : user.displayName,
        "username" : user.username,
      });
      return true;
    }catch(e){
      print(e);
      return false;

    }
  }
  Future<MyUser> getUserInfoById(String uid) async {
    MyUser myUser = MyUser();
   DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
        .collection("user")
        .doc("DxBVSDrVIHg9nMWHzqxVRm8KVN52")
        .get();
   print(documentSnapshot.data());
    return myUser;
  }
}