import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/navigation_provider.dart';
import '../../../providers/units_provider.dart';

class UnitIMGsGrid extends StatelessWidget {
  final List imgList;
  final String unitName;

  const UnitIMGsGrid({Key key, this.imgList, this.unitName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _unitsProvider = Provider.of<UnitsProvider>(context);
    final _height = MediaQuery.of(context).size.height * 0.5;
    final _width = MediaQuery.of(context).size.width;
    final imageIndex = imgList.indexOf(_unitsProvider.currentImage) < 0
        ? 0
        : imgList.indexOf(_unitsProvider.currentImage);

    return Container(
      height: _height,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => context.read<NavigationProvider>().showFullImage(
                  context: context,
                  url: imgList.contains(_unitsProvider.currentImage)
                      ? _unitsProvider.currentImage
                      : imgList.first),
              child: Hero(
                tag: 'fullsize',
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: _width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imgList[imageIndex],
                          // ),
                        ),
                      ),
                    )),
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
                  child: AnimatedContainer(
                    decoration: _unitsProvider.currentImage == imgList[index]
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFF023E8A),
                                width: 3,
                                style: BorderStyle.solid)))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                    duration: const Duration(milliseconds: 400),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () =>
                            _unitsProvider.currentImage = imgList[index],
                        child: CachedNetworkImage(
                          imageUrl: imgList[index],
                          fit: BoxFit.cover,
                        ),
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
