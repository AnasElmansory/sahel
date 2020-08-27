import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';

import '../../../providers/navigation_provider.dart';
import '../../../providers/units_provider.dart';
import 'unit_widget.dart';

class UnitBuilder extends StatefulWidget {
  @override
  _UnitBuilderState createState() => _UnitBuilderState();
}

class _UnitBuilderState extends State<UnitBuilder> {
  List<Unit> cachedUnits;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UnitsProvider>(context);
    return listView(provider.cachedUnits, cachedUnits);
  }
}

Widget listView(List<Unit> server, List<Unit> cache) {
  if (server.isEmpty && cache == null)
    return SpinKitFadingCircle(
      color: Colors.blue,
    );
  else
    return ListView.separated(
      itemCount: server.isNotEmpty ? server.length : cache?.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () => context.read<NavigationProvider>().toUnitDetails(
                server.isNotEmpty ? server[index] : cache[index], context),
            child:
                UnitWidget(server.isNotEmpty ? server[index] : cache[index]));
      },
    );
}
