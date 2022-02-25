import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/screens/edit_product_sceen.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class UserProductItemWidget extends StatelessWidget {
  final Product product;
  const UserProductItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerObj = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.edit_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: product.id)
                  .then((value) {
                if (value != null) {
                  value = value as Map<String, String>;
                  scaffoldMessengerObj
                      .showSnackBar(SnackBar(content: Text(value['message']!)));
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              try {
                await Provider.of<Products>(context, listen: false)
                    .deleteProduct(product.id);
                scaffoldMessengerObj.hideCurrentSnackBar();
                scaffoldMessengerObj.showSnackBar(const SnackBar(
                    content: Text('Product Deleted Successfully',
                        textAlign: TextAlign.center)));
              } catch (error) {
                scaffoldMessengerObj.hideCurrentSnackBar();
                scaffoldMessengerObj.showSnackBar(const SnackBar(
                    content: Text('Could not deleted Product',
                        textAlign: TextAlign.center)));
              }
            },
          ),
        ],
      ),
    );
  }
}
