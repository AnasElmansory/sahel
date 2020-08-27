import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UnitLocation extends StatefulWidget {
  @override
  _UnitLocationState createState() => _UnitLocationState();
}

class _UnitLocationState extends State<UnitLocation> {
  bool _mapLoading = false;
  Future _future =
      Future.delayed(const Duration(milliseconds: 300), () => true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  child: Stack(
                    children: [
                      Positioned(
                          left: (size.width * 0.1) / 2,
                          width: size.width * 0.9,
                          height: size.height * 0.4,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GoogleMap(
                                onMapCreated: (contorller) {
                                  Future.delayed(Duration(milliseconds: 400),
                                      () {
                                    setState(() {
                                      _mapLoading = true;
                                    });
                                  });
                                },
                                gestureRecognizers: Set()
                                  ..add(Factory<EagerGestureRecognizer>(
                                      () => EagerGestureRecognizer())),
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        37.42796133580664, -122.085749655962)),
                              ),
                            ),
                          )),
                      !_mapLoading
                          ? Positioned(
                              left: (size.width * 0.1) / 2,
                              width: size.width * 0.9,
                              height: size.height * 0.4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            )
                          : Container()
                    ],
                  ));
            } else {
              return Container(
                height: size.height * 0.4,
              );
            }
          }),
    );
  }
}
