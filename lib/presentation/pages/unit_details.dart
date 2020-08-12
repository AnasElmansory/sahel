import 'package:flutter/material.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/presentation/widgets/unit_img_grid.dart';

class UnitDetails extends StatelessWidget {
  final Unit unit;
  const UnitDetails({Key key, this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${unit.name}'),
        backgroundColor: Color(0xFF03045e),
      ),
      body: ListView(
        children: [UnitIMGGrid(imgList: unit.images)],
      ),
    );
  }
}
