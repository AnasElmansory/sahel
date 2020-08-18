import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahel/domain/entities/local_user.dart';

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

  Map<String, dynamic> toJson(LocalUser user) => <String, dynamic>{
        'uid': user.uid,
        'name': user.name,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'lastTimeSignIn': user.lastTimeSignIn,
        'photoUrl': user.photoUrl,
        'favs': user.favs,
      };
}
