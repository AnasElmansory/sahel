import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';
import 'package:sahel/features/sahel/presentation/widgets/home_widgets/unit_widget.dart';
import 'package:sahel/features/sahel/providers/navigation_provider.dart';
import 'package:sahel/features/sahel/providers/units_provider.dart';

class UnitBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var navProvider = Provider.of<NavigationProvider>(context);
    var provider = Provider.of<UnitsProvider>(context);
    return StreamBuilder<List<Unit>>(
      stream: provider.getUnitsList(),
      builder: (BuildContext context, AsyncSnapshot<List<Unit>> _unitsList) {
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
              return InkWell(
                  onTap: () => navProvider.toUnitDetails(
                      _unitsList.data[index], context),
                  child: UnitWidget(_unitsList.data[index]));
            },
          );
      },
    );
  }
}
