import 'package:flutter/material.dart';
import 'package:flutter_store/features/shop/screens/delivery/widgets/orders_to_deliver.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../personalization/controllers/logout_controller.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(title: Text('All Orders', style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: false, actions: [

        TCircularIcon(icon: Iconsax.logout, onPressed: () => controller.logout(),)
      ],),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// -- Orders
        child: TOrderListItemsToDeliver(),
      ),
    );
  }
}
