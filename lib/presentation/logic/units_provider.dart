import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/domain/usecases/get_all_units.dart';
import 'package:sahel/presentation/pages/unit_details.dart';

class UnitsProvider extends ChangeNotifier {
  final GetAllUnitsUseCase useCase;
  UnitsProvider(this.useCase);

  Stream unitsList() {
    return useCase.call();
  }

  Future<void> unitDetails(Unit unit, BuildContext context) async {
    return await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UnitDetails(unit: unit)));
  }
}
