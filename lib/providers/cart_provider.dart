import 'package:flutter/foundation.dart';
import 'package:apna_mandi/models/product.dart';
import 'package:apna_mandi/models/seed.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  final String image;
  final bool isSeed;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.isSeed,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          image: existingCartItem.image,
          isSeed: false,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: product.id,
          name: product.name,
          price: product.price,
          quantity: 1,
          image: product.image,
          isSeed: false,
        ),
      );
    }
    notifyListeners();
  }

  void addSeed(Seed seed) {
    if (_items.containsKey(seed.id)) {
      _items.update(
        seed.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          image: existingCartItem.image,
          isSeed: true,
        ),
      );
    } else {
      _items.putIfAbsent(
        seed.id,
        () => CartItem(
          id: seed.id,
          name: seed.name,
          price: seed.price,
          quantity: 1,
          image: seed.image,
          isSeed: true,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    if (_items.containsKey(itemId)) {
      _items.update(
        itemId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: quantity,
          image: existingCartItem.image,
          isSeed: existingCartItem.isSeed,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
