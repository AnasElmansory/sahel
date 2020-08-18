import 'package:flutter/material.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/presentation/pages/book_page.dart';
import 'package:sahel/presentation/pages/home_page.dart';
import 'package:sahel/presentation/pages/sign_in_page.dart';
import 'package:sahel/presentation/pages/unit_details.dart';
import 'package:sahel/presentation/widgets/unit_details_widgets/full_size_img.dart';

class NavigationProvider {
  void _navigation(BuildContext context, Widget _route,
      {bool pushReplacement = false}) {
    pushReplacement
        ? Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => _route))
        : Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => _route));
  }

  void pop(BuildContext context) => Navigator.of(context).pop();

  void toUnitDetails(Unit unit, BuildContext context) =>
      _navigation(context, UnitDetails(unit: unit));

  void showFullImage(BuildContext context, String url) =>
      _navigation(context, FullSizedImage(url: url));

  void toSignInPage(BuildContext context) => _navigation(context, SignInPage());

  void toHomePage(BuildContext context) =>
      _navigation(context, HomePage(), pushReplacement: true);

  void toBookPage(BuildContext context) => _navigation(context, BookPage());
}
