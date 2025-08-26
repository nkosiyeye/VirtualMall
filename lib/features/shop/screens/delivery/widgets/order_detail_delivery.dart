import 'package:flutter/material.dart';
import 'package:flutter_store/features/shop/screens/delivery/delivery_controller.dart';
import 'package:flutter_store/features/shop/screens/order/widgets/order_items.dart';
import 'package:flutter_store/utils/constants/colors.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/order_model.dart';
import 'package:get/get.dart';

import '../navigation_screen.dart';
import 'customer_info.dart';

class OrderDeliveryDetailScreen extends StatelessWidget {
  const OrderDeliveryDetailScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = DeliveryController.instance;
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.updateUserNotification(),
              child: const Text('Start Delivery')),
        ),
      ),
      /// -- AppBar
      appBar: TAppBar(title: Text(order.orderId, style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace/3),
        
          /// -- Orders
          child: Column(
            children: [
              OrderCustomer(order: order),
              const SizedBox(height: TSizes.spaceBtwItems,),
              OrderItems(order: order),
            ],
          ),
        ),
      ),
    );
  }
}