import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';
import 'package:sahel/features/sahel/presentation/widgets/unit_details_widgets/unit_img_grid.dart';
import 'package:sahel/features/sahel/presentation/widgets/unit_details_widgets/unit_location.dart';
import 'package:sahel/features/sahel/providers/navigation_provider.dart';
import 'package:sahel/features/sahel/providers/user_provider.dart';

class UnitDetails extends StatelessWidget {
  final Unit unit;
  UnitDetails({Key key, this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${unit.name}'),
        elevation: 0,
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
                onPressed: () => context.read<UserProvider>().user == null
                    ? navProvider.toSignInPage(context)
                    : navProvider.toBookPage(context,
                        unitRef: unit.unAvailableDays)),
          ),
        ],
      ),
    );
  }
}
