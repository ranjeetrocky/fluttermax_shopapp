import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\$${product.price}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              '\$${product.description}',
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
