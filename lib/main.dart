import 'package:flutter/material.dart';
import 'package:m/view/addEmployee.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), useMaterial3: true, fontFamily: 'Poppins'),
        home: AddEmployee(),
  ));
}

