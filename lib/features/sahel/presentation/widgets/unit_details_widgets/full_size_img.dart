import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/providers/navigation_provider.dart';

//! todo: check connection
//todo: save images to localfile

class FullSizedImage extends StatelessWidget {
  final String url;
  final File imageFile;
  const FullSizedImage({Key key, this.url, this.imageFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height,
      width: _width,
      child: Stack(children: [
        Positioned(
          top: 0,
          height: _height,
          width: _width,
          child: PhotoView(
            customSize: Size(_width, _height),
            initialScale: PhotoViewComputedScale.covered,
            imageProvider: NetworkToFileImage(
              url: url,
              file: imageFile,
            ),
            loadFailedChild: Center(
              child: Icon(Icons.broken_image),
            ),
            backgroundDecoration: BoxDecoration(color: Color(0xFFcaf0f8)),
            tightMode: true,
          ),
        ),
        Positioned(
          top: 30,
          child: Material(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(15),
            child: IconButton(
              color: Color(0xFFFFFFFF),
              icon: Icon(Icons.arrow_back),
              onPressed: () => context.read<NavigationProvider>().pop(context),
            ),
          ),
        ),
      ]),
    );
  }
}
