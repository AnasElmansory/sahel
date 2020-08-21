import 'package:sahel/features/sahel/domain/entities/unit.dart';

abstract class UnitRepository {
  Stream<List<Unit>> getAllUnits();
}
