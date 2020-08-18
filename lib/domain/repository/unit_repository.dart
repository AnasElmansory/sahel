import 'package:sahel/domain/entities/unit.dart';

abstract class UnitRepository {
  Stream<List<Unit>> getAllUnits();
}
