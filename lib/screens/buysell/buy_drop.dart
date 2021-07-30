import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taranga_app/models/buysell.dart';

import 'package:taranga_app/services/database.dart';
import 'package:taranga_app/shared/color.dart';
import 'package:taranga_app/shared/snackbar.dart';

class BuyDropDown extends StatefulWidget {
  final String symbol;

  const BuyDropDown({
    Key? key,
    required this.symbol,
  }) : super(key: key);

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<BuyDropDown> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _buyValue = TextEditingController();
  TextEditingController _buyPrice = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  bool _firstPress = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _buyValue,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter stocks';
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'BuyAmount',
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.green.shade300, width: 2.0),
                ),
              ),
            ),
            TextFormField(
              controller: _buyPrice,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter stocks';
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'BuyPrice',
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.green.shade300, width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  if (_firstPress == true) {
                    _firstPress = false;
                    await DatabaseService(uid: currentUser!.uid).buyStock(
                        BuyModel(
                          symbol: widget.symbol,
                          uid: currentUser!.uid,
                          stockQuantity: int.parse(_buyValue.text),
                          buyPrice: _buyPrice.text,
                        ),
                        context);
                    Navigator.pop(
                      context,
                      Duration(seconds: 0),
                    );
                    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    print('Clicked once');
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.35,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
