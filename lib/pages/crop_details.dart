import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/models/crop.dart';
import 'package:apna_mandi/models/seed.dart';
import 'package:apna_mandi/providers/cart_provider.dart';

class CropDetails extends StatelessWidget {
  final CropCategory crop;

  const CropDetails({
    super.key,
    required this.crop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crop.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Hero(
              tag: crop.name,
              child: Image.asset(
                crop.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Market Price',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '₹${crop.currentPrice}/kg',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    crop.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  // Varieties Section
                  Text(
                    'Popular Varieties',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: crop.varieties.length,
                    itemBuilder: (context, index) {
                      final variety = crop.varieties[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                variety.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(variety.description),
                              const SizedBox(height: 16),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isWideScreen =
                                      constraints.maxWidth > 600;
                                  return isWideScreen
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Seed Price: ₹${variety.seedPrice}/kg',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Growing Season: ${variety.growingSeason}',
                                                ),
                                                Text(
                                                  'Expected Yield: ${variety.expectedYield}',
                                                ),
                                              ],
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                final seed = Seed(
                                                  id: '${crop.name}_${variety.name}',
                                                  name: crop.name,
                                                  varietyName: variety.name,
                                                  cropName: crop.name,
                                                  price: variety.seedPrice,
                                                  image: crop.image,
                                                  description:
                                                      variety.description,
                                                  growingSeason:
                                                      variety.growingSeason,
                                                  yield: variety.expectedYield,
                                                );
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .addSeed(seed);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        '${variety.name} seeds added to cart'),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 12),
                                              ),
                                              icon: const Icon(
                                                  Icons.shopping_cart),
                                              label: const Text('Add to Cart'),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Seed Price: ₹${variety.seedPrice}/kg',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Growing Season: ${variety.growingSeason}',
                                                ),
                                                Text(
                                                  'Expected Yield: ${variety.expectedYield}',
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  final seed = Seed(
                                                    id: '${crop.name}_${variety.name}',
                                                    name: crop.name,
                                                    varietyName: variety.name,
                                                    cropName: crop.name,
                                                    price: variety.seedPrice,
                                                    image: crop.image,
                                                    description:
                                                        variety.description,
                                                    growingSeason:
                                                        variety.growingSeason,
                                                    yield:
                                                        variety.expectedYield,
                                                  );
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .addSeed(seed);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          '${variety.name} seeds added to cart'),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                                ),
                                                icon: const Icon(
                                                    Icons.shopping_cart),
                                                label:
                                                    const Text('Add to Cart'),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Growing Tips Section
                  Text(
                    'Growing Tips',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTipItem(
                            context,
                            'Best Planting Season',
                            crop.growingTips.bestPlantingSeason,
                          ),
                          const SizedBox(height: 16),
                          _buildTipItem(
                            context,
                            'Recommended Soil Type',
                            crop.growingTips.recommendedSoilType,
                          ),
                          const SizedBox(height: 16),
                          _buildTipItem(
                            context,
                            'Water Requirements',
                            crop.growingTips.waterRequirements,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.green,
              ),
        ),
        const SizedBox(height: 4),
        Text(description),
      ],
    );
  }
}
