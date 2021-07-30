// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:taranga_app/models/buysell.dart';
// import 'package:taranga_app/services/database.dart';

// class TestFile extends StatelessWidget {
//   const TestFile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 await DatabaseService(uid: currentUser!.uid).getFirstBuy('API');
//               },
//               child: Text('BuyData'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await DatabaseService(uid: currentUser!.uid)
//                     .getFirstSell('BBC');
//               },
//               child: Text('SellData'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // await DatabaseService(uid: currentUser!.uid).getStocks('BBC');
//               },
//               child: Text('GetStocks'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // await DatabaseService(uid: currentUser!.uid).sellStock(
//                 //     SellModel(
//                 //         symbol: 'BBC',
//                 //         stockQuantity: 50,
//                 //         uid: currentUser.uid));
//               },
//               child: Text('SellStocks'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
