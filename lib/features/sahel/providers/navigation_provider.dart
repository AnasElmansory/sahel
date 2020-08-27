import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dependency_injection.dart';
import '../domain/entities/unit.dart';
import '../domain/usecases/booking_usecases/get_unavailable_days_usecase.dart';
import '../presentation/pages/book_page.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/sign_in_page.dart';
import '../presentation/pages/unit_details.dart';
import '../presentation/widgets/unit_details_widgets/full_size_img.dart';
import 'date_checker_state.dart';
import 'events_state.dart';

class NavigationProvider {
  void _navigation(BuildContext context, Widget _route,
      {bool pushReplacement = false}) {
    pushReplacement
        ? Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => _route))
        : Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => _route));
  }

  void pop(BuildContext context, {String result}) =>
      Navigator.of(context).pop(result);

  void toUnitDetails(Unit unit, BuildContext context) =>
      _navigation(context, UnitDetails(unit: unit));

  void showFullImage({
    BuildContext context,
    @required String url,
  }) =>
      _navigation(
          context,
          FullSizedImage(
            url: url,
          ));

  void toSignInPage(BuildContext context, DocumentReference unitRef) =>
      _navigation(context, SignInPage(unitRef: unitRef));

  void toHomePage(BuildContext context, {bool pReplacment}) =>
      _navigation(context, HomePage(), pushReplacement: pReplacment);

  void toBookPage(BuildContext context,
      {DocumentReference unitRef, bool pReplacment}) {
    _navigation(
        context,
        MultiProvider(providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  EventState(unitRef, getIt<GetUnAvailableDays>())
                    ..getCalenderEvents()),
          ChangeNotifierProvider(create: (context) => DateCheckerState())
        ], child: BookPage(unitRef: unitRef)),
        pushReplacement: pReplacment ?? false);
  }

  //todo: implement phone string validation
  Future<String> toInputPhoneDialog(BuildContext context) async =>
      await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFFf7ebe8),
          title: Text('enter your PhoneNumber'),
          titleTextStyle: TextStyle(
              color: Color(0xFFe54b4b),
              fontSize: 18,
              fontWeight: FontWeight.bold),
          content: TextFormField(
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.center,
            autofocus: true,
            cursorColor: Color(0xFFffa987),
            decoration: InputDecoration(
                hintText: 'phone number', border: InputBorder.none),
            validator: (string) {
              if (string.length == 11 && string.startsWith('01')) {
                return null;
              } else
                return 'enter valid number';
            },
            onFieldSubmitted: (string) => pop(context, result: string),
          ),
        ),
      );
}
