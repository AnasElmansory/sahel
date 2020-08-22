import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UnitLocation extends StatefulWidget {
  @override
  _UnitLocationState createState() => _UnitLocationState();
}

class _UnitLocationState extends State<UnitLocation> {
  Future _future =
      Future.delayed(const Duration(milliseconds: 250), () => true);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Container(
      height: _height * 0.4,
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) => (!snapshot.hasData)
            ? SpinKitFadingCircle(
                color: Color(0xFF023e8a),
              )
            : GoogleMap(
                gestureRecognizers: Set()
                  ..add(Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer())),
                initialCameraPosition: CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962)),
              ),
      ),
    );
  }
}
