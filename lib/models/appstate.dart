import 'package:flutter/material.dart';

@immutable
class AppState {
  final dynamic user;
  final List<dynamic> products;
  final List<dynamic> cartProducts;

  AppState(
      {@required this.user,
      @required this.products,
      @required this.cartProducts});

  factory AppState.initialState() {
    return AppState(user: null, products: [], cartProducts: []);
  }
}
