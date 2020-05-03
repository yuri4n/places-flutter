import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colors/ships_officer.dart';
import 'colors/turkish_aqua.dart';

import 'providers/places.dart';

import 'screens/places_list_screen.dart';
import 'screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Places()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: turkishAqua,
          accentColor: shipsOfficer,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
