import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final title;
  const ProductDetailsScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
