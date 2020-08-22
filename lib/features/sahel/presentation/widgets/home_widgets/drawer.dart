import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class HomeDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;

  const HomeDrawer({Key key, this.scaffoldkey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text("${provider.user.name ?? provider.user.phoneNumber}"),
            accountEmail: Text("${provider.user.email ?? ''}"),
            currentAccountPicture: ClipRRect(
              child: CircleAvatar(
                backgroundImage: provider.user.photoUrl != null
                    ? NetworkImage(provider.user.photoUrl)
                    : null,
              ),
            ),
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () => provider.signOut(context),
          ),
        ],
      ),
    );
  }
}
