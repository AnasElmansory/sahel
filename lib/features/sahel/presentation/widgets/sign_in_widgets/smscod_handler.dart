import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/providers/user_provider.dart';

class SMSHandler extends StatelessWidget {
  final String phone;
  const SMSHandler(this.phone);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormFieldState>();
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: AlertDialog(
        actions: [
          // RaisedButton(
          //     child: Text('resend code'),
          //     onPressed: () async =>
          //         await userProvider.withPhone(phone, context)),

          RaisedButton(
              child: Text('verify'),
              onPressed: () {
                formkey.currentState.save();
                if (userProvider.smsCode != null)
                  Navigator.of(context, rootNavigator: true)
                      .pop(userProvider.smsCode);
              }),
        ],
        title: Text('enter smscode received'),
        content: TextFormField(
          key: formkey,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onSaved: (String sms) => userProvider.smsCode = sms,
        ),
      ),
    );
  }
}
