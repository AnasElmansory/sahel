import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../providers/navigation_provider.dart';
import '../../../providers/units_provider.dart';

class SlideShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UnitsProvider>(context);

    return provider.cachedUnits.isNotEmpty
        ? CarouselSlider.builder(
            itemCount: provider.cachedUnits?.length,
            itemBuilder: (BuildContext context, int index) {
              final _imgHeight =
                  ((MediaQuery.of(context).size.height / 8) * 3) * 0.8;
              final _imgWidth = MediaQuery.of(context).size.width * 0.8;
              return InkWell(
                onTap: () {
                  provider.streamDispose();
                  context
                      .read<NavigationProvider>()
                      .toUnitDetails(provider.cachedUnits[index], context);
                },
                child: Stack(
                  children: [
                    Positioned(
                      height: _imgHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: provider.cachedUnits[index].images.first,
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
                          label: Text('${provider.cachedUnits[index].price}\$'),
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
            ))
        : SpinKitFadingFour(
            color: Color(0xFF023e8a),
          );
  }
}
