import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/dependency_injection.dart';
import 'package:sahel/presentation/logic/navigation_provider.dart';
import 'package:sahel/presentation/logic/units_provider.dart';
import 'package:sahel/presentation/logic/user_provider.dart';
import 'package:sahel/presentation/pages/home_page.dart';
import 'package:sahel/presentation/pages/sign_in_page.dart';

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
      Provider<NavigationProvider>(create: (BuildContext context) => getIt()),
    ],
    child: MyApp(),
  ));
}

//? will it work?! i don't think so
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      home: user != null ? HomePage() : SignInPage(),
    );
  }
}
