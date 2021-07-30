import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:taranga_app/1/test.dart';
import 'package:taranga_app/provider/watchlist_provider.dart';
import 'package:taranga_app/screens/home/home.dart';
import 'package:taranga_app/screens/stocks/stock_details.dart';
import 'package:taranga_app/screens/stocks/view_all_stocks.dart';
import 'package:taranga_app/screens/wrapper/wrapper.dart';
import 'package:taranga_app/services/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WatchListProvider(),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      routes: {
        MyRoutes.homeRoute: (context) => Home(),
        MyRoutes.viewAllStockRoute: (context) => ViewAllStocks(),
        MyRoutes.stockDetails: (context) => StockDetails(),
      },
    );
  }
}
