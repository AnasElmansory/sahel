import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UnitLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Container(
        height: _height * 0.4,
        child: GoogleMap(
          gestureRecognizers: Set()
            ..add(Factory<EagerGestureRecognizer>(
                () => EagerGestureRecognizer())),
          initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962)),
        ));
  }
}
