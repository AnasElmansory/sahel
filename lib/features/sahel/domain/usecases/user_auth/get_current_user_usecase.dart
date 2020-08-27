import 'package:sahel/features/sahel/domain/entities/local_user.dart';
import 'package:sahel/features/sahel/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;
  GetCurrentUserUseCase(this._authRepository);

  Future<LocalUser> call() async => await _authRepository.getCurrentUser();
}
