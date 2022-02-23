import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/product.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:provider/provider.dart';

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
  bool _isloading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
    'isFavorite': false,
  };
  bool _isDataInitialized = false;
  var _newProduct = Product(
    id: '',
    title: 'title',
    description: 'description',
    price: 0,
    imageUrl: 'imageUrl',
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imgFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_isDataInitialized) {
      var productId = ModalRoute.of(context)?.settings.arguments;
      print('productid ${productId}');
      if (productId != null) {
        _newProduct = Provider.of<Products>(context, listen: false)
            .findById(productId as String);
        _initValues = {
          'title': _newProduct.title,
          'description': _newProduct.description,
          'price': _newProduct.price.toString(),
          // 'imageUrl': _newProduct.imageUrl,
          'imageUrl': '',
          'isFavorite': _newProduct.isFavorite,
        };
        _imgUrlController.text = _newProduct.imageUrl;
        _isDataInitialized = true;
      }
    }
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

  Future<void> _saveProduct() async {
    if (!_productForm.currentState!.validate()) {
      return;
    }
    _productForm.currentState?.save();
    setState(() {
      _isloading = true;
    });
    try {
      if (_newProduct.id == '') {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_newProduct);
      } else {
        await Provider.of<Products>(context, listen: false)
            .updateproduct(_newProduct.id, _newProduct);
      }
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (bctx) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(bctx).pop();
              },
              child: const Text('Okay'),
            ),
          ],
          content: const Text('Something went wrong...'),
          title: const Text('An error occured...'),
        ),
      );
    } finally {
      _isloading = false;
      print("Finally ran");
      Navigator.of(context).pop();
    }

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
      body: _isloading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _productForm,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(label: Text('Title')),
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      initialValue: _initValues['title'] as String,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                            id: _newProduct.id,
                            isFavorite: _newProduct.isFavorite,
                            title: value!,
                            description: _newProduct.description,
                            price: _newProduct.price,
                            imageUrl: _newProduct.imageUrl);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Title'; //error message in not valid
                        }
                        return null; //if the valid
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(label: Text('Price')),
                      textInputAction: TextInputAction.next,
                      initialValue: _initValues['price'] as String,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                            id: _newProduct.id,
                            isFavorite: _newProduct.isFavorite,
                            title: _newProduct.title,
                            description: _newProduct.description,
                            price: double.parse(value!),
                            imageUrl: _newProduct.imageUrl);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Price'; //error message in not valid
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please Enter a valid number'; //error message in not valid
                        }
                        if (double.parse(value) < 1) {
                          return 'Price must be greater than 0'; //error message in not valid
                        }
                        return null; //if the valid
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Description')),
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descFocusNode,
                      initialValue: _initValues['description'] as String,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_imgFocusNode),
                      onSaved: (value) {
                        _newProduct = Product(
                            id: _newProduct.id,
                            isFavorite: _newProduct.isFavorite,
                            title: _newProduct.title,
                            description: value!,
                            price: _newProduct.price,
                            imageUrl: _newProduct.imageUrl);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Description'; //error message in not valid
                        }
                        if (value.length < 11) {
                          return 'Description must be longer that 10 characters'; //error message in not valid
                        }
                        return null; //if the valid
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
                                    child: Image.network(
                                      _imgUrlController.text,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator
                                                .adaptive(
                                              strokeWidth: 1,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                label: Text('Paste Image URL')),
                            textInputAction: TextInputAction.done,
                            controller: _imgUrlController,
                            focusNode: _imgFocusNode,
                            // onFieldSubmitted: (_) => setState(() {}),
                            onFieldSubmitted: (_) => _saveProduct(),
                            onSaved: (value) {
                              _newProduct = Product(
                                  id: _newProduct.id,
                                  isFavorite: _newProduct.isFavorite,
                                  title: _newProduct.title,
                                  description: _newProduct.description,
                                  price: _newProduct.price,
                                  imageUrl: value!);
                            },

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Image URL'; //error message in not valid
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please Enter valid Image URL'; //error message in not valid
                              }
                              return null; //if the valid
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
