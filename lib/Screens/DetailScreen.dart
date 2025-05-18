import 'package:assingment/Screens/HomeScreen.dart';
import 'package:assingment/Services/ApiService.dart';
import 'package:assingment/model/ProductModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatelessWidget {
  final ProductModel product;
  final apiService = ApiService();

  Detailscreen({super.key, required this.product});

  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(product.title),
        actions: [
          IconButton(onPressed: ()  {
            SharePlus.instance.share(ShareParams(text: 'https://dummyjson.com/products/${product.id}'));
          }, icon: Icon(Icons.share))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CarouselView with constrained height
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300),
              child: CarouselView.weighted(
                controller: controller,
                flexWeights: [1,7,1],
                padding: const EdgeInsets.all(8),
                children:
                    product.images.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(url, fit: BoxFit.fitHeight),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Product details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.discription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: \$${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Category: ${product.category}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Same Category Products (Mock list)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Similar Products",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),
        FutureBuilder(
          future: apiService.getProductByCategory(product.category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text("Error loading similar products"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text("No similar products found."),
              );
            }

            final data = snapshot.data!;
            final filtered = data.where((p) => p.id != product.id).toList(); // Exclude current product

            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductItemView(product: filtered[index]);
                },
              ),
            );
          },
        ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
