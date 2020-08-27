import 'package:get_it/get_it.dart';

import 'features/sahel/data/datasource/firestore_service.dart';
import 'features/sahel/data/repository/data_auth_repository.dart';
import 'features/sahel/data/repository/data_book_repository.dart';
import 'features/sahel/data/repository/data_unit_repository.dart';
import 'features/sahel/data/services/firebase_auth_service.dart';
import 'features/sahel/domain/repository/auth_repository.dart';
import 'features/sahel/domain/repository/book_repository.dart';
import 'features/sahel/domain/repository/unit_repository.dart';
import 'features/sahel/domain/usecases/booking_usecases/get_unavailable_days_usecase.dart';
import 'features/sahel/domain/usecases/booking_usecases/pick_date_usecase.dart';
import 'features/sahel/domain/usecases/booking_usecases/update_calender_events.dart';
import 'features/sahel/domain/usecases/get_all_units_usecase.dart';
import 'features/sahel/domain/usecases/user_auth/auth_usecase.dart';
import 'features/sahel/domain/usecases/user_auth/get_current_user_usecase.dart';
import 'features/sahel/domain/usecases/user_auth/save_user_db.dart';
import 'features/sahel/domain/usecases/user_auth/sign_out_usecase.dart';
import 'features/sahel/providers/booking_provider.dart';
import 'features/sahel/providers/navigation_provider.dart';
import 'features/sahel/providers/units_provider.dart';
import 'features/sahel/providers/user_provider.dart';

final getIt = GetIt.instance;

void getInit() {
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());

  getIt.registerFactory(() => UnitsProvider(getIt()));
  getIt.registerFactory(() => BookState(
        getIt(),
        getIt(),
      ));

  getIt.registerLazySingleton(() => GetAllUnitsUseCase(getIt()));

  getIt.registerLazySingleton(() => UpdateCalenderEventsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUnAvailableDays(getIt()));
  getIt.registerLazySingleton(() => PickDateUseCase(getIt()));

  getIt.registerLazySingleton<UnitRepository>(() => DataUnitRepository());
  getIt.registerLazySingleton<BookRepository>(() => DataBookRepository());

  getIt.registerLazySingleton(() => NavigationProvider());

  //* user auth
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepository>(() => DataAuthRepository());
  getIt.registerLazySingleton(() => UserProvider(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));
  //* usecases
  getIt.registerLazySingleton(() => SaveUserUseCase(getIt()));
  getIt.registerLazySingleton(() => AuthUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
}
