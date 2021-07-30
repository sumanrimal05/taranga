import 'package:flutter/material.dart';
import 'package:taranga_app/models/stock_data.dart';
import 'package:taranga_app/models/user_stocks.dart';
// import 'package:taranga_app/models/user_stocks.dart';
import 'package:taranga_app/screens/stocks/stock_container.dart';
import 'package:taranga_app/services/api_handler.dart';

class StockListBuilder extends StatefulWidget {
  const StockListBuilder({Key? key}) : super(key: key);

  @override
  _StockListBuilderState createState() => _StockListBuilderState();
}

class _StockListBuilderState extends State<StockListBuilder> {
  late Stream<StockData> _stockData;

  @override
  void initState() {
    super.initState();
    _stockData = APIHandler().getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stockData,
        builder: (BuildContext context, AsyncSnapshot<StockData> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.stockInfo.length,
              itemBuilder: (context, index) {
                var stock = snapshot.data!.stockInfo[index];
                var perChan = stock.percentageChange.toStringAsFixed(2);
                var newChange;
                Color colorVal;
                if (perChan.substring(0, 1) == '-') {
                  newChange = '- ${(perChan.substring(1))}';
                  colorVal = Colors.red;
                } else {
                  newChange = '+ $perChan';
                  colorVal = Colors.green;
                }
                return StockContainer(
                  userStock: UserStock(
                    securityId: stock.securityId,
                    securityName: stock.securityName,
                    symbol: stock.symbol,
                    indexId: stock.indexId,
                    openPrice: stock.openPrice,
                    highPrice: stock.highPrice,
                    lowPrice: stock.lowPrice,
                    totalTradeQuantity: stock.totalTradeQuantity,
                    totalTradeValue: stock.totalTradeValue,
                    lastTradedPrice: stock.lastTradedPrice,
                    percentageChange: stock.percentageChange,
                    lastUpdatedDateTime: stock.lastUpdatedDateTime,
                    lastTradedVolume: stock.lastTradedVolume,
                    previousClose: stock.previousClose,
                    colorVal: colorVal,
                    newChange: newChange,
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
