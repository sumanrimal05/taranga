import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taranga_app/models/stock_data.dart';
import 'package:taranga_app/shared/strings.dart';

class APIHandler {
  Future<StockData> getData() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(Strings.stock_url));
    if (response.statusCode == 200) {
      print('Status code 200');
      return StockData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  Stream<StockData> getDatas() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 10000));
      try {
        print('I am requesting more data');
        StockData stockData = await getData();
        yield stockData;
      } catch (error) {
        print('error');
      }
    }
  }

  // Stream<StockData> getDatas() async* {
  //   try {
  //     StockData stockData = await getData();
  //     yield stockData;
  //   } catch (error) {
  //     print('error');
  //   }
  // }

  //End
}
