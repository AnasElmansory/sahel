import 'package:flutter/material.dart';

import '../../../dependency_injection.dart';
import '../data/models/user_model.dart';
import '../domain/entities/local_user.dart';
import '../domain/usecases/user_auth/auth_usecase.dart';
import '../domain/usecases/user_auth/get_current_user_usecase.dart';
import '../domain/usecases/user_auth/save_user_db.dart';
import '../domain/usecases/user_auth/sign_out_usecase.dart';
import 'navigation_provider.dart';

class UserProvider extends ChangeNotifier {
  final AuthUseCase _authUseCase;
  final GetCurrentUserUseCase _currentUserUseCase;
  final SaveUserUseCase _saveUserUseCase;
  final SignOutUseCase _signOutUseCase;

  UserProvider(
    this._authUseCase,
    this._signOutUseCase,
    this._currentUserUseCase,
    this._saveUserUseCase,
  );

  //* userProfile across the app
  LocalUser _user;
  LocalUser get user => _user;
  set user(LocalUser newUser) {
    _user = newUser;
    notifyListeners();
  }

  String userNameLetters(String name) {
    if (name != null && user != null) {
      final nameList = name.split(' ');
      var fst = nameList.first;
      var last = nameList.last;
      return ("${fst.substring(0, 1)}${last.substring(0, 1)}").toUpperCase();
    } else
      return 'Guest';
  }

//* authentication methods
  Future<void> getCurrentUser() async {
    user = await _currentUserUseCase.call();
  }

  Future<void> withGoogle(BuildContext context) async =>
      await _auth(_authUseCase.googleAuthCall, context);

  Future<void> withFacebook(BuildContext context) async =>
      await _auth(_authUseCase.facebookAuthCall, context);

  Future<void> withPhone(String phone, BuildContext context) async {
    await _authUseCase.phoneAuthCall(phone, context);
  }

  Future<void> signOut(BuildContext context) async =>
      await _signOutUseCase.call().whenComplete(() {
        user = null;
      });

  Future<void> _auth(Future<LocalUser> Function() providerAuthCall,
      BuildContext context) async {
    final _localUser = await providerAuthCall();
    if (_localUser.runtimeType != ErrorUser) {
      final phone =
          await getIt<NavigationProvider>().toInputPhoneDialog(context);
      user = await _saveUserUseCase.call(_localUser, phone: phone);
    } else
      user = _localUser;
  }

  //* smscode for phone authentication
  String _smsCode;
  String get smsCode => _smsCode;
  set smsCode(String value) {
    _smsCode = value;
    notifyListeners();
  }
}
