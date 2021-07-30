import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taranga_app/models/buysell.dart';
import 'package:taranga_app/models/user.dart';
import 'package:taranga_app/shared/snackbar.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _buyCollectionRef =
      FirebaseFirestore.instance.collection('buy');

  final CollectionReference _sellCollectionRef =
      FirebaseFirestore.instance.collection('sell');

  Future createUser(UserModel user) async {
    return await _userCollectionRef
        .doc(uid)
        .set(user.toJson())
        .then((value) => print('User Created'))
        .catchError((error) => print('Failed to create user: $error'));
  }

  //List data from snapshot
  List<MyStocks> myStocksfromSnapshot(dynamic snapshot) {
    return snapshot.docs.map((value) {
      return MyStocks(
          stockQuantity: value.data()['stockQuantity'],
          userId: value.data()['userId'],
          symbol: value.data()['symbol']);
    }).toList();
  }

  //Get portfolio stocks
  Stream<List<MyStocks>> get myStocks {
    return _userCollectionRef
        .doc(uid)
        .collection('stocks')
        .snapshots()
        .map(myStocksfromSnapshot);
  }

  Future addStocks(MyStocks stock) async {
    // print("I am in addStocks");

    return await _userCollectionRef
        .doc(stock.userId)
        .collection('stocks')
        .doc(stock.symbol)
        .set(stock.toMap())
        .then((value) => print("Stocks Added Sucessfully"))
        .catchError((error) => print("Failed to add stock in users: $error"));
  }

  //update user stocks
  Future updateStock(MyStocks stock) async {
    return await _userCollectionRef
        .doc(stock.userId)
        .collection('stocks')
        .doc(stock.symbol)
        .update({'stockQuantity': stock.stockQuantity})
        .then((value) => print("Stocks Added Sucessfully"))
        .catchError((error) => print("Failed to add stock in users: $error"));
  }

  //get stockQuantity from the user
  Future<num?> getStocks(
      {required String symbol, required String userId}) async {
    // print('I am in getStocks');

    try {
      num getStock = await _userCollectionRef
          .doc(userId)
          .collection('stocks')
          .doc(symbol)
          .get()
          .then((dynamic snapshot) {
        return snapshot.data()['stockQuantity'];
      }).catchError((error) {
        print("Data does not exist in user collection $error");
        return null;
      });
      return getStock;
    } catch (error) {
      return null;
    }
  }

  Future ipo({
    required String symbol,
    required String userId,
    required num stockQuantity,
    required BuildContext context,
  }) async {
    //check if the user has the stock or not
    print('Symbol is $symbol');
    print('Stock Quantity is $stockQuantity');
    print('User id is $userId');
    num? value = await getStocks(symbol: symbol, userId: userId);
    if (value == null) {
      await addStocks(MyStocks(
          stockQuantity: stockQuantity, userId: userId, symbol: symbol));
      showCustomSnackBar(context, 'Buy Complete', Colors.green.shade400);
    } else {
      await updateBuyUserStocks(
        symbol: symbol,
        boughtStockQuantity: stockQuantity,
        oldStockQuantity: value,
        userId: userId,
      );
      showCustomSnackBar(context, 'Buy Complete', Colors.green.shade400);
    }
    return 'complete';
  }

//Update Buy Stock
  Future updateBuyUserStocks({
    required String symbol,
    required num boughtStockQuantity,
    required num oldStockQuantity,
    required String userId,
  }) async {
    // print('I am in update user stocks');

    num stockQuantity = boughtStockQuantity + oldStockQuantity;

    return await _userCollectionRef
        .doc(userId)
        .collection('stocks')
        .doc(symbol)
        .update({"stockQuantity": stockQuantity})
        .then((value) => print('Sucessfully updated user Stocks'))
        .catchError((error) => print("Failed to update user stocks: $error"));
  }

//Update Buy Stock
  Future updateSellUserStocks({
    required String symbol,
    required num soldStockQuantity,
    required num oldStockQuantity,
    required String userId,
  }) async {
    // print('I am in update user stocks');

    num stockQuantity = oldStockQuantity - soldStockQuantity;

    return await _userCollectionRef
        .doc(userId)
        .collection('stocks')
        .doc(symbol)
        .update({"stockQuantity": stockQuantity})
        .then((value) => print('Sucessfully updated user Stocks'))
        .catchError((error) => print("Failed to update user stocks: $error"));
  }

//Delete Stocks from buy sell
  Future deleteSellStock(
      {required String symbol,
      required String documentId,
      required String sellPrice}) async {
    // print('I am in deletebuysell stocks');

    return await _sellCollectionRef
        .doc(symbol)
        .collection('stocks')
        .doc(sellPrice)
        .collection('stocks')
        .doc(documentId)
        .delete()
        .then((value) => print("Sucesssfully deleted from sell coll"))
        .catchError(
            (error) => print('Failed to delete stock from sell collection'));
  }

  Future deleteBuyStock(
      {required String symbol,
      required String documentId,
      required String buyPrice}) async {
    // print('I am in deletebuysell stocks');

    return await _buyCollectionRef
        .doc(symbol)
        .collection('stocks')
        .doc(buyPrice)
        .collection('stocks')
        .doc(documentId)
        .delete()
        .then((value) => print("Sucesssfully deleted from buy coll"))
        .catchError(
            (error) => print('Failed to delete stock from buy collection'));
  }

  Future<String> addStockUserSell(String sellDocId, String symbol,
      num stockQuantity, String sellPrice) async {
    //Add sell data to user sellStock
    String message = await _userCollectionRef
        .doc(uid)
        .collection('sellStock')
        .doc(sellDocId)
        .set({
          'symbol': symbol,
          'stockQuantity': stockQuantity,
          'sellPrice': sellPrice,
        })
        .then((value) => 'Sell order placed')
        .catchError((error) => 'Failed to place sell order');
    print("SellDocid is $sellDocId");
    return message;
  }

  Future<String> addStockUserBuy(
      {required String docId,
      required String symbol,
      required num stockQuantity,
      required buyPrice}) async {
    String message = await _userCollectionRef
        .doc(uid)
        .collection('buyStock')
        .doc(docId)
        .set({
          'symbol': symbol,
          'stockQuantity': stockQuantity,
          'buyPrice': buyPrice,
        })
        .then((value) => 'Buy order placed ')
        .catchError((error) => 'Failed to place buy order');
    return message;
  }

  // Add stock to sell collection
  Future sellStock(SellModel stock, BuildContext context) async {
    // print('I am in sellStocks');

    num? userStock = await getStocks(symbol: stock.symbol, userId: uid);
    print('UserStock in sellmodel is $userStock');

    try {
      //check if user have stocks to sell
      if (userStock != null) {
        //Check if the user has sufficient stocks to sell
        if (userStock >= stock.stockQuantity) {
          //if user has enough stocks to sell
          //Add stock to sell collection
          print('UserStock in sell is $userStock');
          print('stockQuantity in sell is ${stock.stockQuantity}');

          // print('I am also here');
          String sellDocId = await _sellCollectionRef
              .doc(stock.symbol)
              .collection('stocks')
              .doc(stock.sellPrice)
              .collection('stocks')
              .add(stock.toMap())
              .then((value) => value.id);

          //Add sell data to user sellStock
          String message = await addStockUserSell(
              sellDocId, stock.symbol, stock.stockQuantity, stock.sellPrice);
          showCustomSnackBar(context, message, Colors.green.shade400);

          // await _userCollectionRef
          //     .doc(uid)
          //     .collection('sellStock')
          //     .doc(sellDocId)
          //     .set({
          //       'symbol': stock.symbol,
          //       'stockQuantity': stock.stockQuantity,
          //     })
          //     .then((value) => print('Added stock in user sellStock'))
          //     .catchError((error) =>
          //         print('Failed to add stock to user sellStock: $error'));
          print("SellDocid is $sellDocId");

          //check if user stock is equal to sell stock
          if (userStock == stock.stockQuantity) {
            //Add sell data to user sellStock
            await _userCollectionRef
                .doc(uid)
                .collection('stocks')
                .doc(stock.symbol)
                .delete()
                .then((value) => print('Sucessfully updated user Stocks'))
                .catchError(
                    (error) => print("Failed to update user stocks: $error"));
          } else {
            //reduce sell data
            await updateSellUserStocks(
              symbol: stock.symbol,
              soldStockQuantity: stock.stockQuantity,
              oldStockQuantity: userStock,
              userId: uid,
            );
          }

          //check if there is a the same stock in buy collection
          //getting docId of data from the sell
          // print('I passed adding stocks to sell');
          await buyMatch(
              symbol: stock.symbol,
              sellStockQuantity: stock.stockQuantity,
              sellerDocId: sellDocId,
              sellerId: stock.uid,
              sellPrice: stock.sellPrice);
          // print('I am now doing buy match');
          return 'done';
        } else {
          showCustomSnackBar(
              context, 'Not enough stocks to sell', Colors.redAccent);
          return 'not enough';
        }
      }
      showCustomSnackBar(
          context, 'Stocks not available in portfolio', Colors.redAccent);
      return 'end';
    } catch (error) {
      print(error.toString());
    }
  }

  // Add stock to buy collection
  Future buyStock(BuyModel stock, BuildContext context) async {
    // print('I am in buyStock');

    try {
      //add stock to buy collection
      // print('Adding stocks to buy coll');
      String docId = await _buyCollectionRef
          .doc(stock.symbol)
          .collection('stocks')
          .doc(stock.buyPrice)
          .collection('stocks')
          .add(stock.toMap())
          .then((value) => value.id);
      // print("sucessfulley added to buy coll");
      print("Buyer doc id is $docId");
      //Add stock to user buyStock
      String message = await addStockUserBuy(
          docId: docId,
          symbol: stock.symbol,
          stockQuantity: stock.stockQuantity,
          buyPrice: stock.buyPrice);
      showCustomSnackBar(context, message, Colors.green.shade400);
      // await _userCollectionRef
      //     .doc(uid)
      //     .collection('buyStock')
      //     .doc(docId)
      //     .set({'symbol': stock.symbol, 'stockQuantity': stock.stockQuantity})
      //     .then((value) => print('Added stock in user buyStock'))
      //     .catchError(
      //         (error) => print('Failed to add stock to user buyStock: $error'));
      await sellMatch(
          symbol: stock.symbol,
          buyStockQuantity: stock.stockQuantity,
          buyerId: stock.uid,
          buyerDocId: docId,
          buyPrice: stock.buyPrice);
      print("No Buy Data");
    } catch (error) {
      print(error.toString());
    }
  }

  Future buyMatch(
      {required String symbol,
      required num sellStockQuantity,
      required sellerId,
      required sellerDocId,
      required sellPrice}) async {
    // print("I am now in buyMatch");
    // DocumentReference _buyDocRef =
    //     FirebaseFirestore.instance.collection('buy').doc(symbol);
    //check if there is a stock in sell collection with same doc id as buy collection
    dynamic buyData = await _buyCollectionRef
        .doc(symbol)
        .collection('stocks')
        .doc(sellPrice)
        .collection('stocks')
        .get()
        .then((value) => value.docs.first.id)
        .catchError((error) => 'error');

    print("buyDAta is $buyData");
    //If Match found there is same stock in sell data
    if (buyData != 'error') {
      print("Match found");
      //check the first element of the stock order
      print("I am in first buy");
      print("Sell price is : $sellPrice");
      FirstBuy? firstBuy =
          await getFirstBuy(symbol, sellPrice).catchError((error) => error);
      // print("Juut passed firstbuy dec");
      print(' firstbuy id ${firstBuy!.documentId}');
      //check if whether the buying and selling is same user or not
      if (uid != firstBuy.uid) {
        // add the stock to the buyer accout
        //First check if user already have the stock in his portfolio if has then update else add

        num buyStockQuantity = firstBuy.stockQuantity;
        print('Buy quantity in buy march is $buyStockQuantity');
        await buySellMatchLogic(
          symbol: symbol,
          buyStockQuantity: buyStockQuantity,
          sellStockQuantity: sellStockQuantity,
          buyDocumentId: firstBuy.documentId,
          sellDocumentId: sellerDocId,
          buyerId: firstBuy.uid,
          sellerId: sellerId,
          sellPrice: sellPrice,
          buyPrice: firstBuy.buyPrice,
        );
      }
    } else {
      print("no match found");
    }
  }

  Future sellMatch(
      {required String symbol,
      required num buyStockQuantity,
      required buyerId,
      required buyerDocId,
      required buyPrice}) async {
    // print("I am in sellMatch");
    print(symbol);

    dynamic sellData = await _sellCollectionRef
        .doc(symbol)
        .collection('stocks')
        .doc(buyPrice)
        .collection('stocks')
        .get()
        .then((value) => value.docs.first.id)
        .catchError((error) => 'error');
    print('Sell data is $sellData');

    // bool getStatus = await _sellCollectionRef
    //     .doc(symbol)
    //     .get()
    //     .then((value) => value.exists);
    // print(getStatus);

    print("sell data is $sellData");
    //If Match found there is same stock in sell data
    if (sellData != 'error') {
      print("Match found");
      //check the first element of the stock order
      // print("I am in first sell");
      FirstSell? firstSell =
          await getFirstSell(symbol, buyPrice).catchError((error) => error);
      print("firstSell is $firstSell");
      // print("Juut passed firstsell dec");
      print('First sell id is ${firstSell!.uid}');
      print(uid);
      print("Buyer id is $buyerId");
      //check if whether the buying and selling is same user or not
      if (uid != firstSell.uid) {
        // add the stock to the buyer accout
        //First check if user already have the stock in his portfolio if has then update else add
        print("Different buyer and seller");
        num sellStockQuantity = firstSell.stockQuantity;
        print('buyStockQuantity $buyStockQuantity');
        await buySellMatchLogic(
            symbol: symbol,
            buyStockQuantity: buyStockQuantity,
            sellStockQuantity: sellStockQuantity,
            sellDocumentId: firstSell.documentId,
            buyDocumentId: buyerDocId,
            buyerId: buyerId,
            sellerId: firstSell.uid,
            buyPrice: buyPrice,
            sellPrice: firstSell.sellPrice);
      } else {
        print('Same buyer');
        print('Exiting');
      }
    } else {
      print("no match found");
    }
  }

  Future buySellMatchLogic(
      {required String symbol,
      required num buyStockQuantity,
      required num sellStockQuantity,
      required String sellDocumentId,
      required String buyDocumentId,
      required String buyerId,
      required String sellerId,
      required String sellPrice,
      required String buyPrice}) async {
    // print('I  am in buy sell match logic');
    dynamic userStock = await getStocks(symbol: symbol, userId: buyerId);
    print("First buyStockQuantity is $buyStockQuantity");
    // Check the buy or sell collection first
    print("user stock in buysellmatch $userStock");
    num remainingQuantity;
    if (buyStockQuantity > sellStockQuantity) {
      print(">");
      remainingQuantity = buyStockQuantity - sellStockQuantity;
      print('Remaining Buy quantity is $remainingQuantity');
      if (userStock == null) {
        print(userStock);
        print("user Stok is null");
        print('I am trying to add stock to user');

        await addStocks(MyStocks(
            symbol: symbol, stockQuantity: sellStockQuantity, userId: buyerId));
      } else {
        print(userStock);
        print('UserStock is not null');
        print("Going to the moon");
        await updateBuyUserStocks(
            symbol: symbol,
            boughtStockQuantity: sellStockQuantity,
            oldStockQuantity: userStock,
            userId: buyerId);
      }
      //update buy and sell collection
      print('I am going to update buy sell coll');
      await updateBuyStockColl(
          symbol: symbol,
          remainingStockQuantity: remainingQuantity,
          documentId: buyDocumentId,
          buyPrice: buyPrice);
      print('I am going to delete stock in sell coll');
      await deleteSellStock(
          symbol: symbol, documentId: sellDocumentId, sellPrice: sellPrice);

      print('Sell Document id id $sellDocumentId');
      print('Buy Document id id $sellDocumentId');
      print('Seller  id id $sellerId');
      print('Buyer  id id $buyerId');
      //update user buyStock
      await _userCollectionRef
          .doc(buyerId)
          .collection('buyStock')
          .doc(buyDocumentId)
          .update({'stockQuantity': remainingQuantity});
      //delete user sellStock
      //Delete user sellStock
      await _userCollectionRef
          .doc(sellerId)
          .collection('sellStock')
          .doc(sellDocumentId)
          .delete()
          .then((value) => print('Deleted from user sellStock'))
          .catchError(
              (error) => print('Failed to delete from user sellStock: $error'));

      return remainingQuantity;
      //second
    } else if (sellStockQuantity == buyStockQuantity) {
      print('=');
      remainingQuantity = 0;
      if (userStock == null) {
        print('I am trying to add stock to user');
        await addStocks(MyStocks(
            symbol: symbol, stockQuantity: buyStockQuantity, userId: buyerId));
      } else {
        print('I cannot find the stock in user so trying to update');
        await updateBuyUserStocks(
            symbol: symbol,
            boughtStockQuantity: buyStockQuantity,
            oldStockQuantity: userStock,
            userId: buyerId);
      }
      //update buy and sell collection
      print("I an going to delete buy stock");
      await deleteBuyStock(
          symbol: symbol, documentId: buyDocumentId, buyPrice: buyPrice);
      await deleteSellStock(
          symbol: symbol, documentId: sellDocumentId, sellPrice: sellPrice);

      print('Sell Document id id $sellDocumentId');
      print('Buy Document id id $buyDocumentId');
      print('Seller  id id $sellerId');
      print('Buyer  id id $buyerId');

      //Delete user sellStock
      await _userCollectionRef
          .doc(sellerId)
          .collection('sellStock')
          .doc(sellDocumentId)
          .delete()
          .then((value) => print('Deleted from user sellStock'))
          .catchError(
              (error) => print('Failed to delete from user sellStock: $error'));

      //Delete user buyStock
      await _userCollectionRef
          .doc(buyerId)
          .collection('buyStock')
          .doc(buyDocumentId)
          .delete()
          .then((value) => print('Deleted from user buyStock'))
          .catchError(
              (error) => print('Failed to delete from user buyStock: $error'));

      return remainingQuantity;
      //third
    } else if (buyStockQuantity < sellStockQuantity) {
      print('<');
      remainingQuantity = sellStockQuantity - buyStockQuantity;
      print('Remaining sell quantuty is $remainingQuantity');
      if (userStock == null) {
        print('I am trying to add stock to user');

        await addStocks(MyStocks(
            symbol: symbol, stockQuantity: buyStockQuantity, userId: buyerId));
      } else {
        await updateBuyUserStocks(
            symbol: symbol,
            boughtStockQuantity: buyStockQuantity,
            oldStockQuantity: userStock,
            userId: buyerId);
      }

      //update buy and sell collection
      await updateSellStockColl(
          symbol: symbol,
          remainingStockQuantity: remainingQuantity,
          documentId: sellDocumentId,
          sellPrice: sellPrice);

      await deleteBuyStock(
          symbol: symbol, documentId: buyDocumentId, buyPrice: buyPrice);
      //update user sellStock
      print('Sell Document id id $sellDocumentId');
      print('Buy Document id id $buyDocumentId');
      print('Seller  id id $sellerId');
      print('Buyer  id id $buyerId');
      await _userCollectionRef
          .doc(sellerId)
          .collection('sellStock')
          .doc(sellDocumentId)
          .update({'stockQuantity': remainingQuantity});
      //delete user sellStock
      //Delete user sellStock
      await _userCollectionRef
          .doc(buyerId)
          .collection('buyStock')
          .doc(buyDocumentId)
          .delete()
          .then((value) => print('Deleted from user buyStock'))
          .catchError(
              (error) => print('Failed to delete from user buyStock: $error'));

      return remainingQuantity;
    }
    print('Trans Complete');
  }

//Get first element in the selllist
  Future<FirstBuy?> getFirstBuy(String symbol, String sellPrice) async {
    try {
      dynamic buy = await _buyCollectionRef
          .doc(symbol)
          .collection('stocks')
          .doc(sellPrice)
          .collection('stocks')
          .orderBy("timeStamp", descending: false)
          .get()
          .then((QuerySnapshot snapshot) {
        dynamic value = snapshot.docs.first.data();
        String docId = snapshot.docs.first.id;
        return FirstBuy(
          documentId: docId,
          uid: value['uid'],
          stockQuantity: value['stockQuantity'],
          buyPrice: value['buyPrice'],
        );
      });
      // print(sell['uid']);
      print('$buy in firstbuy');
      return buy;
    } catch (error) {
      print(error.toString());
    }
  }

  //Get first element in the selllist
  Future<FirstSell?> getFirstSell(String symbol, String buyPrice) async {
    print("I am inside firstSell");
    try {
      dynamic sell = await _sellCollectionRef
          .doc(symbol)
          .collection('stocks')
          .doc(buyPrice)
          .collection('stocks')
          .orderBy("timeStamp", descending: false)
          .get()
          .then((QuerySnapshot snapshot) {
        dynamic value = snapshot.docs.first.data();
        dynamic docId = snapshot.docs.first.id;
        print("value of first sell is $value");
        print("docId of first sell is $docId");
        return FirstSell(
            documentId: docId.toString(),
            uid: value['uid'].toString(),
            stockQuantity: value['stockQuantity'],
            sellPrice: value['sellPrice']);
      });

      print("sell uid is $sell");
      return sell;
    } catch (error) {
      print("Error in first sell is ${error.toString()}");
    }
  }

  Future updateBuyStockColl(
      {required String symbol,
      required num remainingStockQuantity,
      required String documentId,
      required String buyPrice}) async {
    return await _buyCollectionRef
        .doc(symbol)
        .collection('stocks')
        .doc(buyPrice)
        .collection('stocks')
        .doc(documentId)
        .update({"stockQuantity": remainingStockQuantity});
  }

  Future updateSellStockColl(
      {required String symbol,
      required num remainingStockQuantity,
      required String documentId,
      required String sellPrice}) async {
    return await _sellCollectionRef
        .doc(symbol)
        .collection('stocks')
        .doc(sellPrice)
        .collection('stocks')
        .doc(documentId)
        .update({"stockQuantity": remainingStockQuantity});
  }

  //end
}
