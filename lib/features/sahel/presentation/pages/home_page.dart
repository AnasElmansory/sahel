import 'package:flutter/material.dart';

import '../widgets/home_widgets/drawer.dart';
import '../widgets/home_widgets/slide_show.dart';
import '../widgets/home_widgets/units_builder.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: scaffoldkey,
        drawer: HomeDrawer(scaffoldKey: scaffoldkey),
        appBar: AppBar(
          backgroundColor: Color(0xFF0077B6),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: SlideShow(),
                )),
            Divider(
              endIndent: 30,
              indent: 30,
              thickness: 2,
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: _height * 0.7,
                child: UnitBuilder(),
              ),
            )
          ],
        ));
  }
}
