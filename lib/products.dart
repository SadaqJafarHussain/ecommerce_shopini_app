import 'package:badges/badges.dart';
import 'package:bazzar/models/appstate.dart';
import 'package:bazzar/product_item.dart';
import 'package:bazzar/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Products extends StatefulWidget {
  final Function onInit;
  Products({this.onInit});
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final appBarWidgete = PreferredSize(
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          elevation: 0.0,
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: state.user != null
              ? Text(
                  state.user.username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  'Shopini',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lobster',
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
          leading: state.user != null
              ? state.cartProducts.length > 0
                  ? Badge(
                      badgeColor: Colors.lime,
                      badgeContent: Text(
                        '${state.cartProducts.length}',
                        style: TextStyle(color: Colors.black),
                      ),
                      position: BadgePosition(top: 3, end: 8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ))
                  : IconButton(
                      icon: Icon(
                        Icons.store,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                    )
              : Text(''),
          actions: [
            StoreConnector<AppState, VoidCallback>(builder: (_, callBack) {
              return state.user != null
                  ? IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: callBack,
                    )
                  : Text('');
            }, converter: (store) {
              return () => store.dispatch(logOutAction);
            })
          ],
        );
      },
    ),
    preferredSize: Size.fromHeight(60.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff052555),
      appBar: appBarWidgete,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.deepOrange[400], Colors.deepOrange])),
          child: StoreConnector<AppState, AppState>(
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
                      itemCount: state.products.length,
                      itemBuilder: (context, index) => ProductItem(
                        item: state.products[index],
                      ),
                    ),
                  ))
                ],
              );
            },
          )),
      floatingActionButton: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return state.user == null
              ? FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  })
              : Text('');
        },
      ),
    );
  }
}
