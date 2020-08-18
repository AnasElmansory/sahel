import 'package:flutter/material.dart';

class SMSHandler extends StatelessWidget {
  final String verificationId;
  const SMSHandler({Key key, this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('enter smscode received'),
        content: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onSubmitted: (string) {},
        ),
      ),
    );
  }
}
