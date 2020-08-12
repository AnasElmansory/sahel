import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sahel/presentation/logic/units_provider.dart';
import 'package:sahel/presentation/widgets/unit_widget.dart';

class UnitBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UnitsProvider>(context);
    return StreamBuilder(
      stream: provider.unitsList(),
      builder: (BuildContext context, AsyncSnapshot _unitsList) {
        if (_unitsList.connectionState == ConnectionState.waiting)
          return Center(
            child: SpinKitFadingCircle(
              color: Color(0xFF023e8a),
            ),
          );
        else
          return ListView.separated(
            itemCount: _unitsList.data.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return UnitWidget(_unitsList.data[index]);
            },
          );
      },
    );
  }
}
