import 'package:bazzar/item_details.dart';
import 'package:bazzar/models/appstate.dart';
import 'package:flutter/material.dart';
import 'package:bazzar/redux/actions.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductItem extends StatelessWidget {
  final dynamic item;
  ProductItem({this.item});
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
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetails(
                  item: item,
                ),
              ));
        },
        child: GridTile(
            footer: GridTileBar(
              title: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  item['name'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                fit: BoxFit.scaleDown,
              ),
              subtitle: Text(
                '\$${item['price']}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              backgroundColor: Colors.black87,
              trailing: StoreConnector<AppState, AppState>(
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
            ),
            child: Hero(
              tag: item,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      pictureUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )));
  }
}
