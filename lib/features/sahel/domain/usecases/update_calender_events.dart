import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/features/sahel/domain/repository/book_repository.dart';

class UpdateCalenderEventsUseCase {
  final BookRepository _bookRepository;

  const UpdateCalenderEventsUseCase(this._bookRepository);

  void call(Map data, DocumentReference unitRef) {
    _bookRepository.updateCalenderEvents(data, unitRef);
  }
}
