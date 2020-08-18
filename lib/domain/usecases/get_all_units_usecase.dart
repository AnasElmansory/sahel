import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/domain/repository/unit_repository.dart';

class GetAllUnitsUseCase {
  final UnitRepository _repository;
  const GetAllUnitsUseCase(this._repository);

  Stream<List<Unit>> call() {
    return _repository.getAllUnits();
  }
}
