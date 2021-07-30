import 'package:flutter/material.dart';
import 'package:taranga_app/models/stock_data.dart';
import 'package:taranga_app/models/user_stocks.dart';

class StockContainer extends StatelessWidget {
  const StockContainer({Key? key, required this.userStock}) : super(key: key);

  final UserStock userStock;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/stockDetails', arguments: userStock);
      },
      child: Container(
        // margin: EdgeInsets.only(left: 12.0, right: 12.0),
        height: 83,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                //stock name and symbol
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userStock.symbol,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rs ${userStock.lastTradedPrice.toInt()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                //stock price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        userStock.securityName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 58,
                        decoration: BoxDecoration(
                          color: userStock.colorVal,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '${userStock.newChange} %',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
