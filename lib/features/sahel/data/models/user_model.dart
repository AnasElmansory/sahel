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
    Timestamp lastTimeSignIn,
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
      lastTimeSignIn: Timestamp.fromDate(user.metadata.lastSignInTime),
    );
  }
  factory UserModel.fromDsnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> user = snapshot.data();
    return UserModel(
      uid: user['uid'],
      name: user['name'],
      email: user['email'],
      phoneNumber: user['phoneNumber'],
      lastTimeSignIn: user['lastTimeSignIn'],
      photoUrl: user['photoUrl'],
      favs: user['favs'],
    );
  }
  static Map<String, dynamic> toJson(LocalUser user, {String phone}) =>
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
  final String message = 'check your internet Connection';
  const ErrorUser();
}
