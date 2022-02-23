import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editProductScreen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imgFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _productForm = GlobalKey<FormState>();
  var _newProduct = Product(
      id: 'id',
      title: 'title',
      description: 'description',
      price: 0,
      imageUrl: 'imageUrl');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imgFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imgFocusNode.dispose();
    _imgUrlController.dispose();
  }

  void _updateImageUrl() {
    if (!_imgFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveProduct() {
    _productForm.currentState?.save();
    print(_newProduct.id);
    print(_newProduct.title);
    print(_newProduct.price);
    print(_newProduct.description);
    print(_newProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit ProductScreen'),
        actions: [
          IconButton(
              onPressed: _saveProduct, icon: const Icon(Icons.save_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _productForm,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Title')),
                textInputAction: TextInputAction.next,
                autofocus: true,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _newProduct = Product(
                      id: _newProduct.id,
                      title: value!,
                      description: _newProduct.description,
                      price: _newProduct.price,
                      imageUrl: _newProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Price')),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                onSaved: (value) {
                  _newProduct = Product(
                      id: _newProduct.id,
                      title: _newProduct.title,
                      description: _newProduct.description,
                      price: double.parse(value!),
                      imageUrl: _newProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Description')),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_imgFocusNode),
                onSaved: (value) {
                  _newProduct = Product(
                      id: _newProduct.id,
                      title: _newProduct.title,
                      description: value!,
                      price: _newProduct.price,
                      imageUrl: _newProduct.imageUrl);
                },
              ),
              // const SizedBox(
              //   height: 4,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: _imgUrlController.text.isEmpty
                        ? const Center(child: Text('Enter Url'))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: FittedBox(
                              child: Image.network(_imgUrlController.text),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Paste Image URL')),
                      textInputAction: TextInputAction.done,
                      controller: _imgUrlController,
                      focusNode: _imgFocusNode,
                      // onFieldSubmitted: (_) => setState(() {}),
                      onFieldSubmitted: (_) => _saveProduct(),
                      onSaved: (value) {
                        _newProduct = Product(
                            id: _newProduct.id,
                            title: _newProduct.title,
                            description: _newProduct.description,
                            price: _newProduct.price,
                            imageUrl: value!);
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveProduct,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Save Product'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
