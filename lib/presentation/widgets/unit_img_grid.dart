import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/presentation/logic/units_provider.dart';

class UnitIMGGrid extends StatelessWidget {
  final List imgList;

  const UnitIMGGrid({Key key, this.imgList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UnitsProvider>(context);
    final _height = MediaQuery.of(context).size.height * 0.45;
    return Container(
      height: _height,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: provider.currentImage ?? imgList.first,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: imgList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => provider.imgSwitcher(imgList[index]),
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
