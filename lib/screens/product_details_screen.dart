import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  final id;
  const ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
    );
  }
}
