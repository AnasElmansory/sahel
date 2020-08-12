import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/data/repository/data_unit_repository.dart';
import 'package:sahel/domain/usecases/get_all_units.dart';
import 'package:sahel/presentation/logic/units_provider.dart';
import 'package:sahel/presentation/pages/home_page.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (BuildContext context) =>
        UnitsProvider(GetAllUnitsUseCase(DataUnitRepository())),
    child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
