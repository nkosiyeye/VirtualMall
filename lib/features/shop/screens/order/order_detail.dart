import 'package:flutter/material.dart';
import 'package:flutter_store/features/shop/screens/order/widgets/order_items.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(title: Text(order.orderId, style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace/3),
        
          /// -- Orders
          child: OrderItems(order: order),
        ),
      ),
    );
  }
}