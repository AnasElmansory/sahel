import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahel/data/datasource/facebook_sign_service.dart';
import 'package:sahel/data/datasource/google_sign_service.dart';
import 'package:sahel/dependency_injection.dart';
import 'package:sahel/presentation/widgets/sign_in_widgets/smscod_handler.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

//todo: handling errors
//? try to update phone To User
  Future<User> authWithFacebook() async {
    final UserCredential _result =
        await _auth.signInWithCredential(await getIt<FacebookService>().call());

    return _result.user;
  }

  Future<User> authWithGoogle() async {
    final UserCredential _result =
        await _auth.signInWithCredential(await getIt<GoogleService>().call());
    return _result.user;
  }

  Future<User> authWithPhone(String phone, BuildContext context) async {
    UserCredential _result;
    int _forceResendingToken;
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (AuthCredential credential) async {
        _result = await _auth.signInWithCredential(credential);
      },
      verificationFailed: (ex) {
        print('cod: ${ex.code}');
        print('cod: ${ex.message}');
      },
      codeSent: (verificationId, forceResendingToken) async {
        _forceResendingToken = forceResendingToken;
        await showDialog(
            context: context,
            builder: (context) => SMSHandler(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (string) {
        //! resend smscode here
      },
      timeout: Duration(seconds: 30),
    );
    return _result.user;
  }

  Future<void> signOut() async => await _auth.signOut();

  User currentUser() => _auth.currentUser;
}
