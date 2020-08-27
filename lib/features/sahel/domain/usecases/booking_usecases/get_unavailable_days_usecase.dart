import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/features/sahel/domain/repository/book_repository.dart';

class GetUnAvailableDays {
  final BookRepository _bookRepository;

  const GetUnAvailableDays(this._bookRepository);

  Stream<Map<DateTime, List<dynamic>>> call(DocumentReference unitRef) {
    return _bookRepository.getUnitDayEvents(unitRef);
  }
}
