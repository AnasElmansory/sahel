import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/domain/entities/unit.dart';

import '../../../providers/navigation_provider.dart';
import '../../../providers/units_provider.dart';

class SlideShow extends StatefulWidget {
  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  List<Unit> cachedUnit;

  @override
  Widget build(BuildContext context) {
    final unitsState = context.watch<UnitsProvider>();
    return carousel(unitsState.cachedUnits, cachedUnit);
  }
}

Widget carousel(List<Unit> server, List<Unit> cache) {
  if (server.isEmpty && cache == null) {
    return SpinKitFadingCircle(
      color: Colors.blue,
    );
  } else
    return CarouselSlider.builder(
      itemCount: server.isNotEmpty ? server.length : cache.length,
      itemBuilder: (BuildContext context, int index) {
        final _imgHeight = ((MediaQuery.of(context).size.height / 8) * 3) * 0.8;
        final _imgWidth = MediaQuery.of(context).size.width * 0.8;
        return InkWell(
          onTap: () {
            context.read<NavigationProvider>().toUnitDetails(
                server.isNotEmpty ? server[index] : cache[index], context);
          },
          child: Stack(
            children: [
              Positioned(
                height: _imgHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: (server.isNotEmpty ? server[index] : cache[index])
                        .images
                        .first,
                    height: _imgHeight,
                    width: _imgWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  width: _imgWidth,
                  child: Chip(
                    label: Text(
                        '${(server.isNotEmpty ? server[index] : cache[index]).price}\$'),
                    labelStyle: TextStyle(color: Color(0xFFcaf0f8)),
                    backgroundColor: Color(0xFF0096c7),
                  )),
            ],
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
}
