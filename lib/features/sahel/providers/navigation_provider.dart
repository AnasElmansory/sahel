import 'package:flutter/material.dart';

import '../domain/entities/unit.dart';
import '../presentation/pages/book_page.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/sign_in_page.dart';
import '../presentation/pages/unit_details.dart';
import '../presentation/widgets/unit_details_widgets/full_size_img.dart';

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

  void showFullImage(BuildContext context, String url) =>
      _navigation(context, FullSizedImage(url: url));

  void toSignInPage(BuildContext context) =>
      _navigation(context, SignInPage(), pushReplacement: true);

  void toHomePage(BuildContext context) =>
      _navigation(context, HomePage(), pushReplacement: true);

  void toBookPage(BuildContext context) => _navigation(context, BookPage());

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
