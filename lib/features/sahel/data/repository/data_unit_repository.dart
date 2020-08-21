import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/features/sahel/data/datasource/firestore_service.dart';
import 'package:sahel/features/sahel/data/models/unit_model.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';
import 'package:sahel/features/sahel/domain/repository/unit_repository.dart';

class DataUnitRepository extends UnitRepository {
  DataUnitRepository._int();
  static DataUnitRepository _instance = DataUnitRepository._int();
  factory DataUnitRepository() => _instance;

  final firestoreService = FirestoreService();

  List<Unit> _toUnits(List<DocumentSnapshot> snapshots) {
    return snapshots.map<Unit>((snapshot) {
      return UnitModel.fromSnapshot(snapshot);
    }).toList();
  }

  @override
  Stream<List<Unit>> getAllUnits() {
    return firestoreService
        .getUnitsListStream()
        .asyncMap((event) => _toUnits(event.documents));
  }
}
