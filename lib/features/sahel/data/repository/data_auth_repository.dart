import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../dependency_injection.dart';
import '../../../core/error/connection_status.dart';
import '../../domain/entities/local_user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/firestore_service.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';

class DataAuthRepository extends AuthRepository {
  DataAuthRepository._internal();
  static DataAuthRepository _instance = DataAuthRepository._internal();
  factory DataAuthRepository() => _instance;

  final _authService = getIt<AuthService>();
  final _firestoreService = getIt<FirestoreService>();

  @override
  Future<LocalUser> signInWithFacebook() async {
    final Connection _result = await checkConnection();
    if (_result == Connection.Connected) {
      //* call firebse_auth_service
      final UserCredential _userCredential =
          await _authService.authWithFacebook();
      //* create user from firebase_user
      final LocalUser _localUser =
          UserModel.fromFirebaseUser(_userCredential.user);
      return _localUser;
    } else
      return const ErrorUser();
  }

  @override
  Future<LocalUser> signInWithGoogle() async {
    final Connection _result = await checkConnection();
    if (_result == Connection.Connected) {
      //* call firebse_auth_service
      final UserCredential _userCredential =
          await _authService.authWithGoogle();
      //* create user from firebase_user
      final LocalUser _localUser =
          UserModel.fromFirebaseUser(_userCredential.user);
      return _localUser;
    } else
      return const ErrorUser();
  }

//!have some errors here
  @override
  Future<void> singInWithPhone(String phone, BuildContext context) async {
    await _authService.authWithPhone(phone, context);
  }

//todo: handle errors
  @override
  Future<LocalUser> getCurrentUser() async {
    final userResult = _authService.currentUser();
    final connectionState = await checkConnection();
    if (userResult == null) {
      return null;
    } else if (connectionState == Connection.Connected) {
      final firestoreUser =
          await _firestoreService.getUserProfileFromFirestore(userResult);
      return UserModel.fromDsnapshot(firestoreUser);
    } else {
      return null;
    }
  }

  @override
  Future<LocalUser> saveUserToFirestore(LocalUser localUser,
      {String phone}) async {
    final user = await _firestoreService.saveUserProfileToFirestore(localUser,
        phone: phone);

    return UserModel.fromDsnapshot(user);
  }

  @override
  Future<void> singOut() async => await _authService.signOut();
}
