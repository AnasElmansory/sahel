import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/domain/usecases/get_all_units_usecase.dart';

class UnitsProvider extends ChangeNotifier {
  final GetAllUnitsUseCase useCase;
  UnitsProvider(this.useCase);

  Stream<List<Unit>> getUnitsList() => useCase();

  String _currentImage;
  set currentImage(String image) {
    _currentImage = image;
    notifyListeners();
  }

  String get currentImage => _currentImage;
}
