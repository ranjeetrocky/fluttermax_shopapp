import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/orders.dart'
    show Orders;
import 'package:fluttermax_state_management_shopapp/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _ordersFuture;
  Future _obtainOrdersFuture() =>
      Provider.of<Orders>(context, listen: false).fetchAndSet();
  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          snapshot.hasError
              ? print("Error : " + snapshot.error.toString())
              : print('No error');
          print('called');
          print(snapshot.connectionState);
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator.adaptive())
              : snapshot.hasError
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('An error occured'),
                          // ElevatedButton.icon(
                          //     onPressed: () => initState(),
                          //     icon: const Icon(Icons.refresh_rounded),
                          //     label: const Text('Refresh'))
                        ],
                      ),
                    )
                  : Consumer<Orders>(
                      builder: (context, orders, child) => ListView.builder(
                        itemBuilder: (context, index) {
                          return OrderItem(order: orders.orderItems[index]);
                        },
                        itemCount: orders.orderItems.length,
                      ),
                    );
        },
      ),
    );
  }
}
