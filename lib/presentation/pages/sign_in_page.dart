import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:sahel/presentation/logic/navigation_provider.dart';
import 'package:sahel/presentation/logic/user_provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    final _width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<UserProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
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
                      authProvider
                          .withPhone(phone, context)
                          .whenComplete(() => navProvider.toHomePage(context));
                      _controller.clear();
                    },
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SignInButton(Buttons.Google,
                    onPressed: () => authProvider
                        .withGoogle()
                        .whenComplete(() => navProvider.toHomePage(context))),
                SignInButton(Buttons.Facebook,
                    onPressed: () => authProvider
                        .withFacebook()
                        .whenComplete(() => navProvider.toHomePage(context)))
              ]),
        ),
      ),
    );
  }
}
