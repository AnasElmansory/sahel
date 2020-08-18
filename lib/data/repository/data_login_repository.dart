import 'package:flutter/cupertino.dart';
import 'package:sahel/data/datasource/firebase_auth_service.dart';
import 'package:sahel/data/datasource/firestore_service.dart';
import 'package:sahel/data/models/user_model.dart';
import 'package:sahel/dependency_injection.dart';
import 'package:sahel/domain/entities/local_user.dart';
import 'package:sahel/domain/repository/login_repository.dart';

class DataLoginRepository extends LoginRepository {
  DataLoginRepository._internal();
  static DataLoginRepository _instance = DataLoginRepository._internal();
  factory DataLoginRepository() => _instance;

  final _authService = getIt<AuthService>();
  final _firestoreService = getIt<FirestoreService>();

  @override
  Future<LocalUser> signInWithFacebook() async {
    return UserModel.fromFirebaseUser(await _authService.authWithFacebook());
  }

  @override
  Future<LocalUser> signInWithGoogle() async {
    return UserModel.fromFirebaseUser(await _authService.authWithGoogle());
  }

  @override
  Future<LocalUser> singInWithPhone(String phone, BuildContext context) async {
    return UserModel.fromFirebaseUser(
        await _authService.authWithPhone(phone, context));
  }

  @override
  LocalUser getCurrentUser() => _authService.currentUser() != null
      ? UserModel.fromFirebaseUser(_authService.currentUser())
      : null;

  @override
  Future<void> singOut() async => await _authService.signOut();

  @override
  Future<void> saveUserProfile(LocalUser user) async =>
      await _firestoreService.saveUserProfile(user);
}
