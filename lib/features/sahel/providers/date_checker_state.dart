import 'package:flutter/material.dart';

class DateCheckerState extends ChangeNotifier {
  DateCheckerStatus _checking = DateCheckerStatus.Idle;
  DateCheckerStatus get checking => _checking;
  set checking(DateCheckerStatus value) {
    _checking = value;
    notifyListeners();
  }
}

enum DateCheckerStatus { Idle, Loading, Available, UnAvailable }
