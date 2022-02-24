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
  bool _isInitialized = false;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      _initializeOrders();
    });
  }

  Future<void> _initializeOrders() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Orders>(context, listen: false).fetchAndSet();
    } catch (e) {
      print(e);
      await showDialog<Null>(
        context: context,
        builder: (bctx) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () => Navigator.of(bctx).pop(),
                child: const Text('Okay'))
          ],
          content: const Text('Something went wrong...'),
          title: const Text('An error occured'),
        ),
      );
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: RefreshIndicator(
        onRefresh: _initializeOrders,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return OrderItem(order: orders.orderItems[index]);
                },
                itemCount: orders.orderItems.length,
              ),
      ),
    );
  }
}
