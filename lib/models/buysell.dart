import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BuyModel {
  String symbol;
  int stockQuantity;
  String uid;
  String? documentId;
  String buyPrice;
  BuyModel(
      {required this.symbol,
      required this.stockQuantity,
      required this.uid,
      this.documentId,
      required this.buyPrice});
  // DateTime

  Map<String, dynamic> toMap() {
    return {
      'stockQuantity': stockQuantity,
      'uid': uid,
      'documentId': documentId,
      'buyPrice': buyPrice,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }

  factory BuyModel.fromMap(Map<String, dynamic> map) {
    return BuyModel(
      symbol: map['symbol'],
      stockQuantity: map['stockQuantity'],
      uid: map['uid'],
      // documentId: map['documentId'],
      buyPrice: map['buyPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyModel.fromJson(String source) =>
      BuyModel.fromMap(json.decode(source));
}

class SellModel {
  String symbol;
  int stockQuantity;
  String uid;
  String? documentId;
  String sellPrice;
  SellModel({
    required this.symbol,
    required this.stockQuantity,
    required this.uid,
    this.documentId,
    required this.sellPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'stockQuantity': stockQuantity,
      'uid': uid,
      'documentId': documentId,
      'sellPrice': sellPrice,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }

  factory SellModel.fromMap(Map<String, dynamic> map) {
    return SellModel(
        symbol: map['symbol'],
        stockQuantity: map['stockQuantity'],
        uid: map['uid'],
        sellPrice: map['sellPrice']
        // documentId: map['documentId'],
        );
  }

  String toJson() => json.encode(toMap());

  factory SellModel.fromJson(String source) =>
      SellModel.fromMap(json.decode(source));
}

class FirstSell {
  String documentId;
  String? symbol;
  String uid;
  num stockQuantity;
  String sellPrice;

  FirstSell(
      {required this.documentId,
      this.symbol,
      required this.uid,
      required this.stockQuantity,
      required this.sellPrice});

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'symbol': symbol,
      'uid': uid,
      'stockQuantity': stockQuantity,
      'sellPrice': sellPrice,
    };
  }

  factory FirstSell.fromMap(Map<String, dynamic> map) {
    return FirstSell(
        documentId: map['documentId'],
        symbol: map['symbol'],
        uid: map['uid'],
        stockQuantity: map['stockQuantity'],
        sellPrice: map['sellPrice']);
  }

  String toJson() => json.encode(toMap());

  factory FirstSell.fromJson(String source) =>
      FirstSell.fromMap(json.decode(source));
}

class FirstBuy {
  String documentId;
  String? symbol;
  String uid;
  num stockQuantity;
  String buyPrice;
  FirstBuy(
      {required this.documentId,
      this.symbol,
      required this.uid,
      required this.stockQuantity,
      required this.buyPrice});

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'symbol': symbol,
      'uid': uid,
      'stockQuantity': stockQuantity,
      'buyPrice': buyPrice,
    };
  }

  factory FirstBuy.fromMap(Map<String, dynamic> map) {
    return FirstBuy(
      documentId: map['documentId'],
      symbol: map['symbol'],
      uid: map['uid'],
      stockQuantity: map['stockQuantity'],
      buyPrice: map['buyPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirstBuy.fromJson(String source) =>
      FirstBuy.fromMap(json.decode(source));
}
