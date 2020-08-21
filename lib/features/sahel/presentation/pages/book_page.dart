import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/providers/user_provider.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF03045e),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
