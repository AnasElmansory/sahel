import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/sahel/data/models/user_model.dart';

import 'dependency_injection.dart';
import 'features/sahel/presentation/pages/home_page.dart';
import 'features/sahel/presentation/pages/sign_in_page.dart';
import 'features/sahel/providers/Image_file_provider.dart';
import 'features/sahel/providers/navigation_provider.dart';
import 'features/sahel/providers/units_provider.dart';
import 'features/sahel/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getInit();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (BuildContext context) => getIt()..getCurrentUser(),
      ),
      ChangeNotifierProvider<UnitsProvider>(
        create: (BuildContext context) => getIt(),
      ),
      Provider<FileImageProvider>(
        create: (context) => getIt(),
      ),
      Provider<NavigationProvider>(create: (BuildContext context) => getIt()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      home: (user != null && user.runtimeType != ErrorUser)
          ? HomePage()
          : SignInPage(),
    );
  }
}
