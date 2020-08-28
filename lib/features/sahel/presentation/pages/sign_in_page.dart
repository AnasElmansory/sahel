import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/data/models/user_model.dart';
import 'package:sahel/features/sahel/providers/navigation_provider.dart';
import 'package:sahel/features/sahel/providers/user_provider.dart';

class SignInPage extends StatefulWidget {
  final DocumentReference unitRef;

  const SignInPage({Key key, this.unitRef}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _controller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<UserProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);

    void ifErrorUser() {
      if (authProvider.user != null &&
          authProvider.user?.runtimeType == ErrorUser) {
        final errorUser = authProvider.user as ErrorUser;
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
          '${errorUser.message}',
        )));
      } else {
        navProvider.toBookPage(context,
            unitRef: widget.unitRef, pReplacment: true);
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFcaf0f8),
      body: Center(
        child: Container(
          width: _width * 0.6,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 36,
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: 'Enter your phone',
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.green[800],
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none),
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (string) async {
                      String phone = '+2$string';
                      await authProvider
                          .withPhone(phone, context, widget.unitRef)
                          .catchError((err) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('${err.toString()}'),
                        ));
                      });

                      _controller.clear();
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                SignInButton(Buttons.Google,
                    onPressed: () async => await authProvider
                        .withGoogle(context)
                        .whenComplete(ifErrorUser)),
                SignInButton(Buttons.Facebook,
                    onPressed: () async => await authProvider
                        .withFacebook(context)
                        .whenComplete(ifErrorUser))
              ]),
        ),
      ),
    );
  }
}
