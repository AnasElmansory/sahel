import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

//! handle error
//todo: handling errors

class FacebookService {
  Future<AuthCredential> call() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);
    return facebookAuthCredential;
  }
}
