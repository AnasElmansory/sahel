import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahel/features/sahel/domain/entities/either_date.dart';
import 'package:sahel/features/sahel/domain/usecases/pick_date_usecase.dart';
import 'package:sahel/features/sahel/domain/usecases/update_calender_events.dart';
import 'package:sahel/features/sahel/providers/date_checker_state.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/providers/events_state.dart';

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
    final eitherDate = EitherDate(await _pickDateUseCase.call(context));
    if (eitherDate.value != null) {
      if (isStart) {
        startDate = eitherDate.value;
      } else {
        endDate = eitherDate.value;
      }
    } else
      snackError(eitherDate.errMessage, scaffoldkey: scaffoldkey);
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
