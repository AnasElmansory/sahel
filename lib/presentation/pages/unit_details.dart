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
          )
        ],
      ),
    );
  }
}
