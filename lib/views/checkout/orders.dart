import 'package:flutter/material.dart';
import 'package:shopeasy_client/global/constants.dart';
import 'package:shopeasy_client/global/models/order_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<OrderModel> _ordersByCustomer = [];
  @override
  void initState() {
    super.initState();
    _ordersByCustomer = getOrdersByCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: 
        
        _ordersByCustomer.isEmpty 
            ? Center(
                child: Text('No Orders by you yet.',
                    style: Theme.of(context).textTheme.headline5),
              )
            : ListView.separated(
                itemCount: _ordersByCustomer.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_ordersByCustomer[index].date.toString()),
                    //date: _ordersByCustomer[index].date,
                    subtitle: Text('Total: \u20b9 ' +
                        _ordersByCustomer[index].total.toString()),
                    //status: _ordersByCustomer[index].status,
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ));
  }

  List<OrderModel> getOrdersByCustomer() {
    return orderList
        .where((element) => element.customer == customerDetails.id)
        .toList();
  }
}
