import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/sahel/providers/booking_provider.dart';
import 'dependency_injection.dart';
import 'features/sahel/presentation/pages/home_page.dart';
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
        create: (BuildContext context) => getIt(),
      ),
      ChangeNotifierProvider<BookState>(
          create: (BuildContext context) => getIt()),
      ChangeNotifierProvider<UnitsProvider>(
          create: (BuildContext context) => getIt()..getUnitsStream()),
      Provider<NavigationProvider>(create: (BuildContext context) => getIt()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)..getCurrentUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
