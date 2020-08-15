import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/domain/usecases/get_all_units.dart';
import 'package:sahel/presentation/pages/unit_details.dart';

class UnitsProvider extends ChangeNotifier {
  final GetAllUnitsUseCase useCase;
  UnitsProvider(this.useCase);

  String currentImage;
  Stream unitsList() {
    return useCase.call();
  }

  void toUnitDetails(Unit unit, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UnitDetails(unit: unit)));
  }

  void imgSwitcher(String imgUrl) {
    currentImage = imgUrl;
    notifyListeners();
  }
}
