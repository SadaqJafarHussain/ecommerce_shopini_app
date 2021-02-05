import 'package:bazzar/models/appstate.dart';
import 'package:bazzar/models/user.dart';
import 'package:bazzar/redux/actions.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action),
      cartProducts: toggleCartProducts(state.cartProducts, action));
}

toggleCartProducts(cartProducts, action) {
  if (action is ToggleCartProductsAction) {
    return action.products;
  }
  return cartProducts;
}

userReducer(User user, action) {
  if (action is GetUserAction) {
    return action.user;
  } else if (action is LogOutAction) {
    return action.user;
  }
  return user;
}

productsReducer(products, action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}
