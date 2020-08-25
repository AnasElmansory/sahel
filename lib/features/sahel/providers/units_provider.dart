import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';
import 'package:sahel/features/sahel/domain/usecases/get_all_units_usecase.dart';

class UnitsProvider extends ChangeNotifier {
  final GetAllUnitsUseCase useCase;
  UnitsProvider(this.useCase) {
    getUnitsList();
  }

  StreamSubscription _subscription;
  List<Unit> _cachedUnits = List<Unit>();
  List<Unit> get cachedUnits => _cachedUnits;
  set cachedUnits(List<Unit> value) {
    _cachedUnits.addAll(value);
    notifyListeners();
  }

  @override
  void dispose() {
    streamDispose();
    super.dispose();
  }

  void streamDispose() => _subscription?.cancel();

  void getUnitsList() {
    _subscription = useCase().listen((event) {
      cachedUnits = event;
    }, onError: (e) {
      print('unitStreamError: $e');
    });
  }

  String _currentImage;
  set currentImage(String image) {
    _currentImage = image;
    notifyListeners();
  }

  String get currentImage => _currentImage;
}
