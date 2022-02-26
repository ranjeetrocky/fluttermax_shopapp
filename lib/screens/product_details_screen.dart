import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              softWrap: true,
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
            const SizedBox(
              height: 3000,
              width: double.infinity,
            ),
          ])),
        ],
      ),
    );
  }
}
