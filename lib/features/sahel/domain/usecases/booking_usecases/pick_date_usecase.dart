import 'package:sahel/features/sahel/domain/repository/book_repository.dart';

class PickDateUseCase {
  final BookRepository _bookRepository;

  const PickDateUseCase(this._bookRepository);

  Future<DateTime> call(context) async {
    return await _bookRepository.pickDate(context);
  }
}
