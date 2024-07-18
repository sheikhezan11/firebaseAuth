import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid;
  String? email;
  String? password;
  String? username;
  String? displayName;
  String? avatarUrl;
  String? gender;
  String? phone;
  bool? isLoadingStartupData;
  Timestamp? accountCreated;


  MyUser(
  {
    this.uid,
    this.username,
    this.email,
    this.displayName,
    this.password,
    this.avatarUrl,
    this.accountCreated,
    this.gender,
    this.isLoadingStartupData,
    this.phone

}

      );
}
