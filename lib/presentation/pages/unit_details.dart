import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/presentation/logic/navigation_provider.dart';
import 'package:sahel/presentation/widgets/unit_details_widgets/unit_img_grid.dart';
import 'package:sahel/presentation/widgets/unit_details_widgets/unit_location.dart';

class UnitDetails extends StatelessWidget {
  final Unit unit;
  UnitDetails({Key key, this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${unit.name}'),
        backgroundColor: Color(0xFF03045e),
      ),
      body: ListView(
        children: [
          UnitIMGGrid(imgList: unit.images),
          Divider(
            endIndent: 40,
            indent: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                  text: 'الوصف',
                  style: TextStyle(
                      color: Color(0xFF023e8a),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  children: [
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: '${unit.description}',
                        style:
                            TextStyle(color: Color(0xFF03045e), fontSize: 14)),
                  ]),
              textAlign: TextAlign.right,
            ),
          ),
          Divider(
            endIndent: 40,
            indent: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                  text: 'السعر',
                  style: TextStyle(
                      color: Color(0xFF023e8a),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  children: [
                    TextSpan(text: ':  '),
                    TextSpan(
                        text: '${unit.price}',
                        style:
                            TextStyle(color: Color(0xFF03045e), fontSize: 14)),
                  ]),
              textAlign: TextAlign.right,
            ),
          ),
          UnitLocation(),
          Center(
            child: RaisedButton(
              child: Text('احجز'),
              textColor: Color(0xFFcaf0f8),
              color: Color(0xFF0077b6),
              onPressed: () async => await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Color(0xFFcaf0f8),
                        title: Text('you havn\'t Signed In'),
                        titleTextStyle: TextStyle(
                            color: Color(0xFF0077b6),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        content: Text('Sign In to continue to book page'),
                        actions: [
                          Center(
                            child: RaisedButton(
                              color: Color(0xFFFFFFFF),
                              elevation: 0.1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text('Sign In'),
                              textColor: Color(0xFF03045e),
                              onPressed: () => navProvider.toBookPage(context),
                            ),
                          )
                        ],
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
