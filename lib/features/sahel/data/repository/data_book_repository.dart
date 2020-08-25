import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../dependency_injection.dart';
import '../../domain/repository/book_repository.dart';
import '../datasource/firestore_service.dart';

class DataBookRepository extends BookRepository {
  DataBookRepository._internal();
  static DataBookRepository _instance = DataBookRepository._internal();
  factory DataBookRepository() {
    if (_instance == null) {
      return _instance = DataBookRepository._internal();
    } else
      return _instance;
  }

  final firestore = getIt<FirestoreService>();

  @override
  Stream<Map<DateTime, List<dynamic>>> getUnitDayEvents(
      DocumentReference unitRef) {
    return firestore
        .getDaysEvents(unitRef)
        .asyncMap<Map<DateTime, List<dynamic>>>((event) {
      List list = event.data()['unAvailableDays'];
      Map<DateTime, List<dynamic>> map = Map.fromIterable(list,
          key: (item) => DateTime.parse(item.keys.first),
          value: (item) => item.values.first);
      return map;
    });
  }

  @override
  Future<DateTime> pickDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    final time = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: initialDate.add(const Duration(days: 60)),
    );
    return time;
  }

  @override
  Future<void> updateCalenderEvents(
          Map data, DocumentReference unitRef) async =>
      await firestore.updateCalenderEvents(data, unitRef);
}
