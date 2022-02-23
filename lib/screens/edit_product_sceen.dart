import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editProductScreen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit ProductScreen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            child: ListView(
          children: [TextFormField()],
        )),
      ),
    );
  }
}
