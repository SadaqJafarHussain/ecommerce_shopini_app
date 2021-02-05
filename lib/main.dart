import 'package:bazzar/cart_page.dart';
import 'package:bazzar/models/appstate.dart';
import 'package:bazzar/products.dart';
import 'package:bazzar/redux/reducers.dart';
import 'package:flutter/material.dart';
import 'package:bazzar/homescreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'models/appstate.dart';
import 'package:redux/redux.dart';

import 'redux/actions.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        routes: {
          '/': (BuildContext context) => Products(
                onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProductsAction);
                },
              ),
          '/home': (BuildContext context) => HomeScreen(),
          '/cart': (BuildContext context) => CartPage(),
        },
      ),
    );
  }
}
