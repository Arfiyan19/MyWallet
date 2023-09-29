import 'package:myWallet/constant/route_constants.dart';
import 'package:myWallet/pages/AddExpenditurePage.dart';
import 'package:myWallet/pages/AddIncomePage.dart';
import 'package:myWallet/pages/DetailCashFlowPage.dart';
import 'package:myWallet/pages/HomePage.dart';
import 'package:myWallet/pages/LoginPage.dart';
import 'package:myWallet/pages/SettingsPage.dart';
import 'package:myWallet/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => HomePage(),
  settingsRoute: (BuildContext context) => SettingsPage(),
  addExpenseRoute: (BuildContext context) => AddExpenditurePage(),
  addIncomeRoute: (BuildContext context) => AddIncomePage(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlowPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyWallet",
      theme: ThemeData(primaryColor: Colors.green.shade800),
      routes: routes,
    );
  }
}
