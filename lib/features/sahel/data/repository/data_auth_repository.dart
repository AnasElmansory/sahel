import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sahel/features/core/error/connection_status.dart';

import '../../../../dependency_injection.dart';
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

  //! error not yet handled here
  @override
  Future<LocalUser> singInWithPhone(String phone, BuildContext context) async {
    LocalUser _localUser;
    await _authService.authWithPhone(phone, context).whenComplete(
        () async => _localUser = await saveUserToFirestore(getCurrentUser()));

    return _localUser;
  }

  @override
  LocalUser getCurrentUser() => _authService.currentUser() != null
      ? UserModel.fromFirebaseUser(_authService.currentUser())
      : null;

  @override
  Future<void> singOut() async => await _authService.signOut();

  @override
  Future<LocalUser> saveUserToFirestore(LocalUser localUser,
      {String phone}) async {
    final user =
        await _firestoreService.saveUserProfile(localUser, phone: phone);
    return UserModel.fromDsnapshot(user);
  }
}
