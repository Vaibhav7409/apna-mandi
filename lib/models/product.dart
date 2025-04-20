import 'package:logging/logging.dart';

// Initialize logger
final _logger = Logger('Product');

class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String image;
  final String category;
  final String unit;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
      'unit': unit,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      image: json['image'],
      category: json['category'],
      unit: json['unit'],
    );
  }

  /// Extracts numeric price from formatted string (e.g., "₹300/50kg" => 300.0)
  double get numericPrice {
    try {
      if (price.toString().isEmpty) {
        _logger.warning('Price is empty for $name');
        return 0.0;
      }

      // First split by '/' to separate price from unit (e.g., "₹300" from "50kg")
      String priceValue = price.toString().split('/')[0];

      // Then remove all non-numeric characters except decimal point
      String cleanPrice = priceValue.replaceAll(RegExp(r'[^0-9.]'), '');

      if (cleanPrice.isEmpty) {
        _logger.warning('No numeric value found in price for $name: $price');
        return 0.0;
      }

      double? parsedPrice = double.tryParse(cleanPrice);
      if (parsedPrice == null) {
        _logger.warning('Failed to parse price for $name: $price');
        return 0.0;
      }

      return parsedPrice;
    } catch (e) {
      _logger.warning('Error parsing numeric price for $name: $price | $e');
      return 0.0;
    }
  }
}
