import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahel/data/datasource/firestoreService.dart';
import 'package:sahel/data/models/unit_model.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/domain/repository/unit_repository.dart';

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
  Stream getAllUnits() {
    return firestoreService
        .unitStream()
        .map((event) => _toUnits(event.documents));
  }
}