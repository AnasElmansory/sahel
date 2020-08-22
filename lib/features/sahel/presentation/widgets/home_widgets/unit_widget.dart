import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';
import 'package:sahel/features/sahel/providers/Image_file_provider.dart';

class UnitWidget extends StatelessWidget {
  final Unit _unit;

  const UnitWidget(this._unit, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height * 0.25,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _unit.name,
                  style: TextStyle(color: Color(0xFF023e8a)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
                height: _height * 0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _unit.images.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final imgFileProvider =
                        Provider.of<FileImageProvider>(context);
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                            fit: BoxFit.cover,
                            width: _width / 3,
                            image: NetworkToFileImage(
                              url: _unit.images[index],
                              file:
                                  imgFileProvider.getIMGFile(_unit.name, index),
                            )));
                  },
                )),
          )
        ],
      ),
    );
  }
}
