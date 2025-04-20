import 'package:apna_mandi/models/product.dart';
import 'package:logging/logging.dart';

// Initialize logger
final _logger = Logger('CartItem');

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice {
    try {
      return product.numericPrice * quantity;
    } catch (e) {
      _logger.warning('Error calculating total price for ${product.name}: $e');
      return 0.0;
    }
  }
}

class Cart {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(Product product) {
    _logger.info('Adding product: ${product.name}, price: ${product.price}');

    if (_items.containsKey(product.name)) {
      _items[product.name]!.quantity++;
    } else {
      _items[product.name] = CartItem(product: product);
    }
  }

  void removeItem(String productName) {
    _items.remove(productName);
  }

  void updateQuantity(String productName, int quantity) {
    if (quantity <= 0) {
      removeItem(productName);
      return;
    }

    if (_items.containsKey(productName)) {
      _items[productName]!.quantity = quantity;
    }
  }

  void clear() {
    _items.clear();
  }
}
