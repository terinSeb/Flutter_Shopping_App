import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScrenn extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScrenn({Key? key}) : super(key: key);

  @override
  State<OrdersScrenn> createState() => _OrdersScrennState();
}

class _OrdersScrennState extends State<OrdersScrenn> {
  // ignore: unused_field
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrwaer(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItem(
                  order: orderData.orders[i],
                ),
              ));
  }
}
