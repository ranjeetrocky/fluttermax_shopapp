import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit ProductScreen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Title')),
              textInputAction: TextInputAction.next,
              autofocus: true,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
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
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Description')),
              textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_imgFocusNode),
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
                    textInputAction: TextInputAction.next,
                    // keyboardType: TextInputType.multiline,
                    controller: _imgUrlController,
                    focusNode: _imgFocusNode,
                    onFieldSubmitted: (_) => setState(() {}),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
