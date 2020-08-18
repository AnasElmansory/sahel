import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/presentation/logic/user_provider.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final user = provider.user;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name ?? user.phoneNumber),
            accountEmail: Text(user.email ?? ''),
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () => provider.signOut(),
          ),
        ],
      ),
    );
  }
}
