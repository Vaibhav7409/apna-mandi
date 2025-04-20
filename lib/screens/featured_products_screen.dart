import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/models/product.dart';
import 'package:apna_mandi/widgets/featured_product_card.dart';
import 'package:apna_mandi/providers/cart_provider.dart';
import 'package:apna_mandi/screens/cart_screen.dart';

class FeaturedProductsScreen extends StatelessWidget {
  // Sample featured products with local images
  final List<Product> featuredProducts = [
    Product(
      id: "rice_1",
      name: 'Fresh Rice',
      image: 'images/rice.png',
      price: 80.0,
      description: 'Premium quality rice from local farms',
      category: 'Grains',
      unit: 'kg',
    ),
    Product(
      id: "wheat_1",
      name: 'Organic Wheat',
      image: 'images/wheat.png',
      price: 45.0,
      description: 'Organic wheat from premium farms',
      category: 'Grains',
      unit: 'kg',
    ),
    Product(
      id: "corn_1",
      name: 'Sweet Corn',
      image: 'images/corn.png',
      price: 35.0,
      description: 'Fresh sweet corn',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: "beans_1",
      name: 'Green Beans',
      image: 'images/beans.png',
      price: 60.0,
      description: 'Fresh green beans',
      category: 'Vegetables',
      unit: 'kg',
    ),
    Product(
      id: "urea_1",
      name: 'Urea Fertilizer',
      image: 'images/urea.png',
      price: 266.0,
      description: 'High quality urea fertilizer',
      category: 'Fertilizer',
      unit: 'bag',
    ),
    Product(
      id: "dap_1",
      name: 'DAP Fertilizer',
      image: 'images/DAP.jpeg',
      price: 1350.0,
      description: 'Premium DAP fertilizer',
      category: 'Fertilizer',
      unit: 'bag',
    ),
  ];

  FeaturedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Products'),
        backgroundColor: Colors.green,
        actions: [
          // Cart Icon with Badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return cartProvider.itemCount > 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartProvider.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: featuredProducts.length,
        itemBuilder: (context, index) {
          return FeaturedProductCard(
            product: featuredProducts[index],
            onAddToCart: (product) {
              // Add to cart using the CartProvider
              Provider.of<CartProvider>(context, listen: false)
                  .addItem(product);

              // Show feedback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart'),
                  duration: const Duration(seconds: 1),
                  action: SnackBarAction(
                    label: 'View Cart',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
