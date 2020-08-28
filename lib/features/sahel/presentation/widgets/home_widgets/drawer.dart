import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class HomeDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeDrawer({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(
                  "${provider.user?.name ?? provider.user?.phoneNumber ?? 'Guest'}"),
              accountEmail: Text("${provider.user?.email ?? ''}"),
              currentAccountPicture: CircularProfileAvatar(
                provider.user?.photoUrl != null ? provider.user?.photoUrl : '',
                cacheImage: true,
                borderWidth: 2,
                borderColor: Colors.white,
                initialsText:
                    Text(provider.userNameLetters(provider.user?.name)),
                // child:  Icon(
                //         Icons.account_circle,
                //         size: 30,
              )),
          IgnorePointer(
            ignoring: provider.user == null,
            child: ListTile(
              enabled: provider.user != null,
              title: Text('Sign Out'),
              onTap: () => provider.signOut(context),
            ),
          ),
        ],
      ),
    );
  }
}
