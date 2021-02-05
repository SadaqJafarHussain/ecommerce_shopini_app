import 'package:bazzar/models/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  double price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xff052555),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          width: MediaQuery.of(context).size.width * 10,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 320, top: 20, bottom: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.store_rounded,
                        size: 50,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'set up your payment',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/master.png',
                  width: 80,
                  height: 60,
                ),
                Image.asset(
                  'images/paypal.png',
                  width: 50,
                  height: 50,
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _moneyToPay(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Card Number',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 25),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ))),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'MM/YY',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 25),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ))),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'CVC',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 25),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ))),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 50,
            width: 350,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Color(0xff052555),
              onPressed: () {},
              child: Text(
                'Pay',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ))
      ],
    ));
  }

  _moneyToPay() {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          state.cartProducts.forEach((product) {
            if (price == 0) {
              price = product['price'] + price;
            }
          });
          return Text(
            'Total Price :  \$${price}',
            style: TextStyle(color: Colors.black, fontSize: 18),
          );
        });
  }
}
