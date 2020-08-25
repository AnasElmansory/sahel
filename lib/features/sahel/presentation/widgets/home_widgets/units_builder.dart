import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/presentation/widgets/home_widgets/unit_widget.dart';
import 'package:sahel/features/sahel/providers/navigation_provider.dart';
import 'package:sahel/features/sahel/providers/units_provider.dart';

class UnitBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UnitsProvider>(context);
    return provider.cachedUnits.isNotEmpty
        ? ListView.separated(
            itemCount: provider.cachedUnits?.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    provider.streamDispose();
                    context
                        .read<NavigationProvider>()
                        .toUnitDetails(provider.cachedUnits[index], context);
                  },
                  child: UnitWidget(provider.cachedUnits[index]));
            },
          )
        : SpinKitFadingFour(
            color: Color(0xFF023e8a),
          );
  }
}
