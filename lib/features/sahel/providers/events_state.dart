import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahel/features/sahel/domain/usecases/get_unavailable_days_usecase.dart';

class EventState extends ChangeNotifier {
  final DocumentReference _reference;
  final GetUnAvailableDays _getUnAvailableDays;

  EventState(this._reference, this._getUnAvailableDays);

  Map<DateTime, List<dynamic>> _events = Map<DateTime, List<dynamic>>();
  Map<DateTime, List<dynamic>> get events => _events;
  set events(Map<DateTime, List<dynamic>> value) {
    _events.addAll(value);
    notifyListeners();
  }

  StreamSubscription streamSubScription;

  @override
  void dispose() {
    streamSubScription?.cancel();
    super.dispose();
  }

  void getCalenderEvents() {
    streamSubScription = _getUnAvailableDays.call(_reference).listen((event) {
      events = event;
    });
  }
}
