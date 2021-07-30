import 'dart:convert';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final num userBalance;
  UserModel(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.userBalance});

  UserModel.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        fullName = data['fullName'],
        email = data['email'],
        userBalance = data['userBalance'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'userBalance': userBalance,
    };
  }
}

class MyStocks {
  String? symbol;
  num stockQuantity;
  String userId;
  MyStocks({
    this.symbol,
    required this.stockQuantity,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'stockQuantity': stockQuantity,
      'userId': userId,
    };
  }

  factory MyStocks.fromMap(Map<String, dynamic> map) {
    return MyStocks(
      symbol: map['symbol'],
      stockQuantity: map['stockQuantity'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyStocks.fromJson(String source) =>
      MyStocks.fromMap(json.decode(source));
}

class WatchlistModel {
  final String securityName;
  final String symbol;
  final String ltp;
  final String percentageChange;

  WatchlistModel(
      this.securityName, this.symbol, this.ltp, this.percentageChange);
}
