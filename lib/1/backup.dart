// import 'package:flutter/material.dart';
// import 'package:taranga_app/models/buysell.dart';
// import 'package:taranga_app/services/database.dart';
// import 'package:taranga_app/shared/constants.dart';

// class BuySellDialogue extends StatefulWidget {
//   const BuySellDialogue({Key? key}) : super(key: key);

//   @override
//   _BuySellDialogueState createState() => _BuySellDialogueState();
// }

// class _BuySellDialogueState extends State<BuySellDialogue> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// GlobalKey<FormState> _formBuyKey = GlobalKey<FormState>();
// GlobalKey<FormState> _formSellKey = GlobalKey<FormState>();

// Future<void> showBuyDialogue(
//     BuildContext context, var currentUser, String symbol) async {
//   return await showDialog(
//       context: context,
//       builder: (context) {
//         final TextEditingController _stockQuantity = TextEditingController();
//         return AlertDialog(
//           backgroundColor: Colors.grey[200],
//           content: Form(
//             key: _formBuyKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: _stockQuantity,
//                   keyboardType: TextInputType.number,
//                   validator: (val) {
//                     return val!.isEmpty ? null : 'field cannot be empty';
//                   },
//                   decoration: textInputDecoration.copyWith(
//                     // fillColor: Colors.grey[200],
//                     hintText: 'StockQuantity',
//                     hintStyle: TextStyle(
//                       color: Colors.grey[400],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     DatabaseService(uid: currentUser!.uid).buyStock(
//                         BuyModel(
//                           symbol: symbol,
//                           uid: currentUser!.uid,
//                           stockQuantity: int.parse(_stockQuantity.text),
//                         ),
//                         context);
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.green[400],
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Text(
//                       'Buy',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

// Future<void> showSellDialogue(
//     BuildContext context, var currentUser, String symbol) async {
//   return await showDialog(
//       context: context,
//       builder: (context) {
//         final TextEditingController _stockQuantity = TextEditingController();
//         return AlertDialog(
//           backgroundColor: Colors.grey[200],
//           content: Form(
//             key: _formSellKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: _stockQuantity,
//                   keyboardType: TextInputType.number,
//                   validator: (val) {
//                     return val!.isEmpty ? null : 'field cannot be empty';
//                   },
//                   decoration: textInputDecoration.copyWith(
//                     // fillColor: Colors.grey[200],
//                     hintText: 'StockQuantity',
//                     hintStyle: TextStyle(
//                       color: Colors.grey[400],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     dynamic value =
//                         DatabaseService(uid: currentUser!.uid).sellStock(
//                             SellModel(
//                               symbol: symbol,
//                               uid: currentUser!.uid,
//                               stockQuantity: int.parse(_stockQuantity.text),
//                             ),
//                             context);
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.redAccent,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Text(
//                       'Sell',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
