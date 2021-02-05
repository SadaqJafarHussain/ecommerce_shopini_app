import 'dart:convert';

import 'package:bazzar/models/appstate.dart';
import 'package:bazzar/models/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ThunkAction<AppState>> getUserAction(Store<AppState> stor) async {
  final pref = await SharedPreferences.getInstance();
  final String storedUser = pref.getString('user');
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  stor.dispatch(GetUserAction(user));
}

class GetUserAction {
  final User _user;
  User get user => this._user;
  GetUserAction(this._user);
}

class LogOutAction {
  final User _user;
  User get user => this._user;
  LogOutAction(this._user);
}

Future<ThunkAction<AppState>> getProductsAction(Store<AppState> stor) async {
  final respons = await http.get('http://10.0.2.2:5000/products');
  final List<dynamic> data = jsonDecode(respons.body);
  stor.dispatch(GetProductsAction(data));
}

class GetProductsAction {
  final List<dynamic> _products;
  List<dynamic> get products => _products;
  GetProductsAction(this._products);
}

Future<ThunkAction<AppState>> logOutAction(Store<AppState> stor) async {
  final pref = await SharedPreferences.getInstance();
  pref.remove('user');
  User user;
  stor.dispatch(LogOutAction(user));
}

ThunkAction<AppState> toggleCartProductsAction(dynamic cartProduct) {
  return (Store<AppState> store) {
    List<dynamic> products = store.state.cartProducts;
    final int index =
        products.indexWhere((product) => product['id'] == cartProduct['id']);
    bool isInCart = index > -1 == true;
    List<dynamic> updatedList = List.from(products);
    if (isInCart) {
      updatedList.removeAt(index);
    } else {
      updatedList.add(cartProduct);
    }
    store.dispatch(ToggleCartProductsAction(updatedList));
  };
}

class ToggleCartProductsAction {
  final List<dynamic> _products;
  ToggleCartProductsAction(this._products);
  List<dynamic> get products => _products;
}
