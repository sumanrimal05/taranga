import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taranga_app/models/buysell.dart';

import 'package:taranga_app/services/database.dart';
import 'package:taranga_app/shared/color.dart';
import 'package:taranga_app/shared/snackbar.dart';

class SellDropDown extends StatefulWidget {
  final String symbol;

  const SellDropDown({
    Key? key,
    required this.symbol,
  }) : super(key: key);

  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<SellDropDown> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _sellValue = TextEditingController();
  TextEditingController _sellPrice = TextEditingController();

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
              controller: _sellValue,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter stocks';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Sell amount',
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
              ),
            ),
            TextFormField(
              controller: _sellPrice,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter stocks';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'SellPrice',
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
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
                    await DatabaseService(uid: currentUser!.uid).sellStock(
                        SellModel(
                          symbol: widget.symbol,
                          uid: currentUser!.uid,
                          stockQuantity: int.parse(
                            _sellValue.text,
                          ),
                          sellPrice: _sellPrice.text,
                        ),
                        context);

                    Navigator.pop(
                      context,
                      Duration(seconds: 0),
                    );
                    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.35,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Sell',
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
