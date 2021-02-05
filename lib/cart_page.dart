import 'package:bazzar/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'product_item.dart';
import 'models/appstate.dart';

class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreditCard()));
        },
        child: Icon(
          Icons.attach_money,
          size: 40,
          color: Colors.deepOrange,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: Container(
        child: _cartTab(),
      ),
    );
  }

  _cartTab() {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Column(
          children: [
            Expanded(
                child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemCount: state.cartProducts.length,
                itemBuilder: (context, index) => ProductItem(
                  item: state.cartProducts[index],
                ),
              ),
            ))
          ],
        );
      },
    );
  }

  _cardsTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: InkWell(
              child: Row(
            children: [
              Icon(
                Icons.add_circle,
                color: Colors.deepOrange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'pay via new card',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ],
          )),
        ),
        Divider(
          height: 40,
          color: Colors.deepOrange,
        ),
        Text('lfdsjfdsjfkdsjfk'),
      ],
    );
  }
}
