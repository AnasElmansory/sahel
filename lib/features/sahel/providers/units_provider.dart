import 'dart:async';

import 'package:flutter/material.dart';

import '../domain/entities/unit.dart';
import '../domain/usecases/get_all_units_usecase.dart';

class UnitsProvider extends ChangeNotifier {
  final GetAllUnitsUseCase _getUnitsUseCase;

  UnitsProvider(this._getUnitsUseCase);

  StreamSubscription _subscription;
  List<Unit> _cachedUnits = List<Unit>();
  List<Unit> get cachedUnits => _cachedUnits;
  set cachedUnits(List<Unit> value) {
    _cachedUnits.addAll(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void getUnitsStream() async {
    _subscription = _getUnitsUseCase().listen((event) {
      cachedUnits = event;
    }, onError: (e) {
      print('unitStreamError: $e');
    });
  }

  String _currentImage;
  String get currentImage => _currentImage;
  set currentImage(String image) {
    _currentImage = image;
    notifyListeners();
  }
}
