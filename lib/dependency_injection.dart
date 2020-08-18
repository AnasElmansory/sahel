import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sahel/data/datasource/facebook_sign_service.dart';
import 'package:sahel/data/datasource/firebase_auth_service.dart';
import 'package:sahel/data/datasource/firestore_service.dart';
import 'package:sahel/data/datasource/google_sign_service.dart';
import 'package:sahel/data/repository/data_login_repository.dart';
import 'package:sahel/data/repository/data_unit_repository.dart';
import 'package:sahel/domain/repository/login_repository.dart';
import 'package:sahel/domain/repository/unit_repository.dart';
import 'package:sahel/domain/usecases/get_all_units_usecase.dart';
import 'package:sahel/domain/usecases/user_authentication_usecase.dart';
import 'package:sahel/presentation/logic/navigation_provider.dart';
import 'package:sahel/presentation/logic/units_provider.dart';
import 'package:sahel/presentation/logic/user_provider.dart';

final getIt = GetIt.instance;

void getInit() {
  getIt.registerFactory(() => UnitsProvider(getIt()));
  getIt.registerFactory(() => UserAuthenticationUseCase(getIt()));
  // getIt.registerFactory(() => FirebaseAuth.instance);
  //! hope it will work
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton(() => UserProvider(getIt()));
  //!^
  getIt.registerLazySingleton(() => GetAllUnitsUseCase(getIt()));
  getIt.registerLazySingleton(() => NavigationProvider());

  getIt.registerLazySingleton<UnitRepository>(() => DataUnitRepository());
  getIt.registerLazySingleton<LoginRepository>(() => DataLoginRepository());

  getIt.registerLazySingleton(() => FacebookService());
  getIt.registerLazySingleton(() => GoogleService());
  // print(getIt.isReady(instance: FirebaseAuth.instance));
}
