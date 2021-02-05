import 'package:bazzar/redux/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models/appstate.dart';

class ItemDetails extends StatelessWidget {
  final dynamic item;
  ItemDetails({this.item});

  bool _isInCart(AppState state, String id) {
    final List<dynamic> products = state.cartProducts;
    final int index = products.indexWhere((product) => product['id'] == id);
    bool _isTrue = index > -1 == true;
    if (_isTrue) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://10.0.2.2:5000${item["image"]["url"]}';
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(item['name']),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.deepOrange[400], Colors.deepOrange])),
        child: Column(
          children: [
            Expanded(
                child: Hero(
                    tag: item,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(pictureUrl),
                            fit: BoxFit.cover,
                          )),
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                item['name'],
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${item['price']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    StoreConnector<AppState, AppState>(
                      converter: (store) => store.state,
                      builder: (_, state) {
                        return state.user != null
                            ? IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: _isInCart(state, item['id'])
                                      ? Colors.cyan
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(toggleCartProductsAction(item));
                                })
                            : Text('');
                      },
                    ),
                  ],
                )),
            Container(
                height: 200,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      item['description'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
