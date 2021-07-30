import 'package:flutter/material.dart';
import 'package:taranga_app/screens/home/balance_display.dart';
import 'package:taranga_app/screens/home/portfolio_stocks.dart';
import 'package:taranga_app/screens/home/watchlist.dart';
import 'package:taranga_app/screens/nav/bottom_nav.dart';
import 'package:taranga_app/screens/stocks/view_all_stocks.dart';
import 'package:taranga_app/shared/color.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: bgColor,
                // color: Colors.amber,
              ),
              // padding: EdgeInsets.only(left: 30),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      //Header section of the app
                      Container(
                        // color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.drag_indicator,
                              color: Colors.black45,
                              size: 30,
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: Color(0xffeadcff),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.notifications_outlined,
                                  color: Color(0xff664fd1)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      //Balance
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Portfolio value display container
                            BalanceDisplay(),
                            SizedBox(height: 20),
                            PortStock(),
                            SizedBox(height: 20),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'WatchList',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('See Details'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      //WatchList
                      Expanded(child: WatchList()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewAllStocks()));
        },
        backgroundColor: Color(0xff5240a1),
        child: Icon(Icons.swap_horiz_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(),
    );
  }
}
