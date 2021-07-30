import 'package:flutter/material.dart';

class UserStock {
  UserStock({
    required this.securityId,
    required this.securityName,
    required this.symbol,
    required this.indexId,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.totalTradeQuantity,
    required this.totalTradeValue,
    required this.lastTradedPrice,
    required this.percentageChange,
    required this.lastUpdatedDateTime,
    required this.lastTradedVolume,
    required this.previousClose,
    required this.colorVal,
    required this.newChange,
  });

  String securityId = '0';
  String securityName;
  String symbol;
  num indexId;
  num openPrice;
  num highPrice;
  num lowPrice;
  num totalTradeQuantity;
  dynamic totalTradeValue;
  num lastTradedPrice;
  num percentageChange;
  DateTime lastUpdatedDateTime;
  dynamic lastTradedVolume;
  num previousClose;
  Color colorVal;
  String newChange;

  factory UserStock.fromJson(Map<String, dynamic> json) => UserStock(
        securityId: json["securityId"],
        securityName: json["securityName"],
        symbol: json["symbol"],
        indexId: json["indexId"],
        openPrice: json["openPrice"],
        highPrice: json["highPrice"],
        lowPrice: json["lowPrice"],
        totalTradeQuantity: json["totalTradeQuantity"],
        totalTradeValue: json["totalTradeValue"],
        lastTradedPrice: json["lastTradedPrice"],
        percentageChange: json["percentageChange"].toDouble(),
        lastUpdatedDateTime: DateTime.parse(json["lastUpdatedDateTime"]),
        lastTradedVolume: json["lastTradedVolume"],
        previousClose: json["previousClose"],
        colorVal: json["colorVal"],
        newChange: json["newChange"],
      );

  Map<String, dynamic> toJson() => {
        "securityId": securityId,
        "securityName": securityName,
        "symbol": symbol,
        "indexId": indexId,
        "openPrice": openPrice,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
        "totalTradeQuantity": totalTradeQuantity,
        "totalTradeValue": totalTradeValue,
        "lastTradedPrice": lastTradedPrice,
        "percentageChange": percentageChange,
        "lastUpdatedDateTime": lastUpdatedDateTime.toIso8601String(),
        "lastTradedVolume": lastTradedVolume,
        "previousClose": previousClose,
      };
}
