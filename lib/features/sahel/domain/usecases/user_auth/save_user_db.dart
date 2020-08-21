import 'package:sahel/features/sahel/domain/entities/local_user.dart';
import 'package:sahel/features/sahel/domain/repository/auth_repository.dart';

class SaveUserUseCase {
  final AuthRepository _authRepository;
  SaveUserUseCase(this._authRepository);

  Future<LocalUser> call(LocalUser user, {String phone}) async =>
      await _authRepository.saveUserToFirestore(user, phone: phone);
}
