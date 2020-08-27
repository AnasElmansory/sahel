import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sahel/dependency_injection.dart';
import 'package:sahel/features/sahel/data/models/user_model.dart';
import 'package:sahel/features/sahel/domain/repository/auth_repository.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> authWithFacebook() async {
    //* login with facebook

    final LoginResult _result =
        await FacebookAuth.instance.login(permissions: ['email']);
    final FacebookAuthCredential _credential =
        FacebookAuthProvider.credential(_result.accessToken.token);

    //* login to firebase
    final UserCredential _userCredential =
        await _auth.signInWithCredential(_credential);
    return _userCredential;
  }

  Future<UserCredential> authWithGoogle() async {
    //* signIn with google
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser.authentication;
    final _credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //* login to firebase

    final UserCredential _userCredential =
        await _auth.signInWithCredential(_credential);
    return _userCredential;
  }

  Future<void> authWithPhone(String phone, BuildContext context) async =>
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          final user = await _auth.signInWithCredential(credential);
          await getIt<AuthRepository>()
              .saveUserToFirestore(UserModel.fromFirebaseUser(user.user));
        },
        verificationFailed: (ex) async {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                        '${ex.code != null ? ex.code : 'qouta exceeded'}',
                        style: TextStyle(color: Colors.red)),
                    content: Text(
                        '${ex.message != null ? ex.message : 'try again later...'}'),
                  ));
        },
        codeSent: (verificationId, forceResendingToken) {},
        codeAutoRetrievalTimeout: (verificationId) {},
      );

  Future<void> signOut() async => await _auth.signOut();

  User currentUser() => _auth.currentUser;
}
