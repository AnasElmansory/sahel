import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/usecases/booking_usecases/pick_date_usecase.dart';
import '../domain/usecases/booking_usecases/update_calender_events.dart';
import 'date_checker_state.dart';
import 'events_state.dart';

class BookState extends ChangeNotifier {
  final PickDateUseCase _pickDateUseCase;
  final UpdateCalenderEventsUseCase _updateCalenderEventsUseCase;

  BookState(
    this._pickDateUseCase,
    this._updateCalenderEventsUseCase,
  );

  DateTime _startDate;
  DateTime get startDate => _startDate;
  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  DateTime _endDate;
  DateTime get endDate => _endDate;
  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  Future<void> pickDate(
    context,
    bool isStart,
    GlobalKey<ScaffoldState> scaffoldkey,
  ) async {
    DateTime pickedDate = await _pickDateUseCase.call(context);
    if (pickedDate != null) {
      if (isStart) {
        startDate = pickedDate;
      } else {
        endDate = pickedDate;
      }
    } else
      snackError('canceled', scaffoldkey: scaffoldkey);
  }

  Map<String, List<dynamic>> calculateDuration(
    String phoneNumber,
    DocumentReference unitRef,
  ) {
    Map<String, List<dynamic>> duration = Map();
    for (int i = startDate.day; i <= endDate.day; i++) {
      duration.addAll({
        startDate.add(Duration(days: i - startDate.day)).toString(): [
          phoneNumber
        ]
      });
    }
    return duration;
  }

  void checkIfAvailable(String phoneNumber, DocumentReference unitRef,
      GlobalKey<ScaffoldState> scaffoldkey, BuildContext context) {
    if (startDate != null && endDate != null) {
      final data = calculateDuration(phoneNumber, unitRef);
      final checkerStatus =
          Provider.of<DateCheckerState>(context, listen: false);
      final events = context.read<EventState>().events;
      checkerStatus.checking = DateCheckerStatus.Loading;
      if (data != null) {
        if (!events.containsKey(startDate) && !events.containsKey(endDate)) {
          Future.delayed(Duration(seconds: 2), () {
            checkerStatus.checking = DateCheckerStatus.Available;
            _updateCalenderEventsUseCase.call(data, unitRef);
          });
        } else {
          checkerStatus.checking = DateCheckerStatus.UnAvailable;
          Future.delayed(Duration(seconds: 1),
              () => checkerStatus.checking = DateCheckerStatus.Idle);
          snackError("unAvailableDays", scaffoldkey: scaffoldkey);
        }
      }
    } else
      snackError("pick Date first", scaffoldkey: scaffoldkey);
  }

  void snackError(String errMessage, {GlobalKey<ScaffoldState> scaffoldkey}) =>
      scaffoldkey.currentState
          .showSnackBar(SnackBar(content: Text('$errMessage')));
}
