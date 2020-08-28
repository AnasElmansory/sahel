import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahel/features/sahel/domain/entities/local_user.dart';

class UserModel extends LocalUser {
  const UserModel({
    String name,
    String uid,
    String email,
    String phoneNumber,
    String photoUrl,
    DateTime lastTimeSignIn,
    List favs,
  }) : super(
            uid: uid,
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            lastTimeSignIn: lastTimeSignIn,
            photoUrl: photoUrl,
            favs: favs);

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
      lastTimeSignIn: user.metadata.lastSignInTime,
    );
  }
  factory UserModel.fromDsnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> user = snapshot.data();
    return UserModel(
      uid: user['uid'],
      name: user['name'],
      email: user['email'],
      phoneNumber: user['phoneNumber'],
      lastTimeSignIn: user['lastTimeSignIn'].toDate(),
      photoUrl: user['photoUrl'],
      favs: user['favs'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      lastTimeSignIn: json['lastTimeSignIn'],
      photoUrl: json['photoUrl'],
      favs: json['favs'],
    );
  }

  static Map<String, dynamic> toJson(LocalUser user,
          {String phone, bool convertTime = false}) =>
      <String, dynamic>{
        'uid': user.uid,
        'name': user.name,
        'email': user.email,
        'phoneNumber': user.phoneNumber ?? phone,
        'lastTimeSignIn': user.lastTimeSignIn,
        'photoUrl': user.photoUrl,
        'favs': user.favs,
      };
}

class ErrorUser extends LocalUser {
  String message = 'check your internet Connection';

  @override
  String toString() {
    return '$message';
  }

  ErrorUser({this.message});
}
