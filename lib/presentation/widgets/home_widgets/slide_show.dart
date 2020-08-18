import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sahel/domain/entities/unit.dart';
import 'package:sahel/presentation/logic/navigation_provider.dart';
import 'package:sahel/presentation/logic/units_provider.dart';

class SlideShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final provider = Provider.of<UnitsProvider>(context);
    return StreamBuilder<List<Unit>>(
        stream: provider.getUnitsList(),
        builder: (BuildContext context, AsyncSnapshot<List<Unit>> _units) {
          if (_units.connectionState == ConnectionState.waiting)
            return Center(
              child: SpinKitFadingCircle(
                color: Color(0xFF023e8a),
              ),
            );
          else {
            return CarouselSlider.builder(
                itemCount: _units.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final _imgHeight =
                      ((MediaQuery.of(context).size.height / 8) * 3) * 0.8;
                  final _imgWidth = MediaQuery.of(context).size.width * 0.8;
                  return InkWell(
                    onTap: () =>
                        navProvider.toUnitDetails(_units.data[index], context),
                    child: Stack(
                      children: [
                        Positioned(
                          height: _imgHeight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: _units.data[index].images.first,
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
                              label: Text('${_units.data[index].price} ج'),
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
                ));
          }
        });
  }
}
