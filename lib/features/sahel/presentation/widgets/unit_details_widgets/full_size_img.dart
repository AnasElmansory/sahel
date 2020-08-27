import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/navigation_provider.dart';

class FullSizedImage extends StatelessWidget {
  final String url;

  const FullSizedImage({Key key, this.url}) : super(key: key);
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
            heroAttributes: PhotoViewHeroAttributes(tag: 'fullsize'),
            customSize: Size(_width, _height),
            initialScale: PhotoViewComputedScale.covered,
            imageProvider: CachedNetworkImageProvider(
              url,
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
