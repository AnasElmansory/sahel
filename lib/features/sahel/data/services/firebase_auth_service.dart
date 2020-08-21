import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (ex) {
          print('cod: ${ex.code}');
          print('cod: ${ex.message}');
        },
        codeSent: (verificationId, forceResendingToken) async {
          // _forceResendingToken = forceResendingToken;
          // String smscode = await showDialog<String>(
          //     context: context, builder: (context) => SMSHandler(phone));
          // PhoneAuthCredential phoneAuthCredential =
          //     PhoneAuthProvider.credential(
          //         verificationId: verificationId, smsCode: smscode);
          // await _auth.signInWithCredential(phoneAuthCredential);
          print('smsCode');
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          // String smscode = await showDialog<String>(
          //     context: context, builder: (context) => SMSHandler(phone));
          // PhoneAuthCredential phoneAuthCredential =
          //     PhoneAuthProvider.credential(
          //         verificationId: verificationId, smsCode: smscode);
          // await _auth.signInWithCredential(phoneAuthCredential);
          print('codeauto re timout');
        },
      );

  Future<void> signOut() async => await _auth.signOut();

  User currentUser() => _auth.currentUser;

  // Future<void> forceResendToken(PhoneAuth phoneAuth) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneAuth.phoneNumber,
  //     verificationCompleted: phoneAuth.verificationCompleted,
  //     verificationFailed: phoneAuth.verificationFailed,
  //     codeSent: phoneAuth.codeSent,
  //     codeAutoRetrievalTimeout: phoneAuth.codeAutoRetrievalTimeout,
  //     forceResendingToken: phoneAuth.forceResendingToken,
  //   );
  // }
}
