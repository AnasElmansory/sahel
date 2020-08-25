import 'package:sahel/features/sahel/domain/repository/book_repository.dart';

class PickDateUseCase {
  final BookRepository _bookRepository;

  const PickDateUseCase(this._bookRepository);

  Future<dynamic> call(context) async {
    try {
      return await _bookRepository.pickDate(context);
    } catch (e) {
      return e.toString();
    }
  }
}
