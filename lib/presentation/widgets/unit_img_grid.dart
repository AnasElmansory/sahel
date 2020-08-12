import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UnitIMGGrid extends StatelessWidget {
  final List imgList;

  const UnitIMGGrid({Key key, this.imgList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Container(
      height: _height * 0.25,
      child: GridView.builder(
        itemCount: imgList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: CachedNetworkImage(imageUrl: imgList[index]),
          );
        },
      ),
    );
  }
}
