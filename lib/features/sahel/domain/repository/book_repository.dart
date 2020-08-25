import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class BookRepository {
  Stream<Map<DateTime, dynamic>> getUnitDayEvents(DocumentReference unitRef);

  Future<DateTime> pickDate(BuildContext context);

  Future<void> updateCalenderEvents(Map data, DocumentReference unitRef);
}
