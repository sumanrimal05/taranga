import 'package:flutter/material.dart';
import 'package:taranga_app/models/user_stocks.dart';
import 'dart:collection';

class WatchListProvider extends ChangeNotifier {
  // Item item;
  List<UserStock> _listStocks = [];

  // List<Item> get items => _listItems;
  UnmodifiableListView<UserStock> get listStocks =>
      UnmodifiableListView(_listStocks);

  void addItems(UserStock stock) {
    _listStocks.add(stock);
    print('Stock added in watchlist $stock');
    notifyListeners();
  }

  void removeAll() {
    _listStocks.clear();
    notifyListeners();
  }

  void deleteSelected(index) {
    _listStocks.removeWhere((_item) => _item == listStocks[index]);
    notifyListeners();
  }
}
