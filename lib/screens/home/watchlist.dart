import 'package:flutter/material.dart';
import 'package:taranga_app/provider/watchlist_provider.dart';
import 'package:taranga_app/screens/stocks/stock_container.dart';
import 'package:provider/provider.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    return context.watch<WatchListProvider>().listStocks.isEmpty
        ? Center(child: Text('Empty'))
        : ListView.builder(
            itemCount: context.watch<WatchListProvider>().listStocks.length,
            itemBuilder: (BuildContext context, index) {
              return StockContainer(
                  userStock:
                      context.watch<WatchListProvider>().listStocks[index]);
            });
  }
}
