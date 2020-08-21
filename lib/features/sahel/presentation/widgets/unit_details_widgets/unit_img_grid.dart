import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/navigation_provider.dart';
import '../../../providers/units_provider.dart';

class UnitIMGGrid extends StatelessWidget {
  final List imgList;

  const UnitIMGGrid({Key key, this.imgList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final unitsProvider = Provider.of<UnitsProvider>(context);
    final _height = MediaQuery.of(context).size.height * 0.5;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => navProvider.showFullImage(
                  context, unitsProvider.currentImage),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: _width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imgList.contains(unitsProvider.currentImage)
                          ? unitsProvider.currentImage
                          : imgList.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: imgList.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => unitsProvider.currentImage = imgList[index],
                      child: CachedNetworkImage(
                        imageUrl: imgList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
