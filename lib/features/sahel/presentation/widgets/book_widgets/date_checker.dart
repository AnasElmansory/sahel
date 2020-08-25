import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sahel/features/sahel/providers/date_checker_state.dart';
import 'package:provider/provider.dart';

class DateChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final checkState = context.watch<DateCheckerState>().checking;
    Widget _child;
    switch (checkState) {
      case DateCheckerStatus.Idle:
        _child = Text(
          '...',
          style: const TextStyle(color: Colors.black38, fontSize: 25),
        );
        break;
      case DateCheckerStatus.Loading:
        _child = Container(
          height: height * 0.1,
          child: SpinKitDualRing(
            color: Color(0xFF023e8a),
          ),
        );
        break;
      case DateCheckerStatus.Available:
        _child = Icon(
          Icons.done,
          color: Colors.green,
        );
        break;
      case DateCheckerStatus.UnAvailable:
        _child = Icon(
          Icons.error_outline,
          color: Colors.red,
        );
        break;
      default:
    }
    return Container(
      height: height * 0.1,
      child: Center(
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => ScaleTransition(
                  child: child,
                  scale: animation,
                ),
            child: _child),
      ),
    );
  }
}
