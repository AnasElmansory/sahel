import 'package:sahel/features/sahel/domain/entities/local_user.dart';
import 'package:sahel/features/sahel/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;
  GetCurrentUserUseCase(this._authRepository);

  LocalUser call()  =>  _authRepository.getCurrentUser();
  Stream<LocalUser> watchUser(String uid) => _authRepository.getCurrentUserStream(uid);
}
