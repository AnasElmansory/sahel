import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:provider/provider.dart';

import '../../../providers/Image_file_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/units_provider.dart';

class UnitIMGGrid extends StatelessWidget {
  final List imgList;
  final String unitName;

  const UnitIMGGrid({Key key, this.imgList, this.unitName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _unitsProvider = Provider.of<UnitsProvider>(context);
    final _imageFileProvider = Provider.of<FileImageProvider>(context);
    final _height = MediaQuery.of(context).size.height * 0.5;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => context.read<NavigationProvider>().showFullImage(
                  context: context,
                  url: _unitsProvider.currentImage ?? imgList.first,
                  imageFile: _imageFileProvider.getIMGFile(
                      unitName, imgList.indexOf(_unitsProvider.currentImage))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: _width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      fit: BoxFit.cover,
                      //? will it work
                      image: NetworkToFileImage(
                        file: imgList.contains(_unitsProvider.currentImage)
                            ? _imageFileProvider.getIMGFile(unitName,
                                imgList.indexOf(_unitsProvider.currentImage))
                            : null,
                        url: imgList.contains(_unitsProvider.currentImage)
                            ? _unitsProvider.currentImage
                            : imgList.first,
                      ),
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
                      onTap: () => _unitsProvider.currentImage = imgList[index],
                      child: Container(
                          child: Image(
                        fit: BoxFit.cover,
                        image: NetworkToFileImage(
                          url: imgList[index],
                          file: _imageFileProvider.getIMGFile(unitName, index),
                        ),
                      )),
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
