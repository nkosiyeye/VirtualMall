import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_store/features/shop/controllers/product/order_controller.dart';
import 'package:flutter_store/features/shop/models/order_model.dart';
import 'package:flutter_store/features/shop/screens/delivery/navigation_screen.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../order_detail.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return Obx(
      () => FutureBuilder(
        key: Key(controller.refreshData.value.toString()),
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {
          final widget =
              TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
          if (widget != null) return widget;

          final orders = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
              child: OrderItem(
                dark: dark,
                order: orders[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.dark,
    required this.order,
  });

  final bool dark;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: dark ? TColors.dark : TColors.light,
      child: GestureDetector(
        onTap: () => Get.to(() => OrderDetailScreen(
              order: order,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// -- Row 1
            Row(
              children: [
                /// 1 - Icon
                const Icon(Iconsax.ship),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),

                /// 2 - Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderStatusText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        order.orderDate.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                ),

                /// 3 - Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.arrow_right_34,
                      size: TSizes.iconSm,
                    ))
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            /// -- Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// 1 - Icon
                      const Icon(Iconsax.tag),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),

                      /// 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              order.orderId,
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      /// 1 - Icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),

                      /// 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              order.deliveryDate != null
                                  ? order.deliveryDate.toString()
                                  : 'Unknown',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: order.items.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: TSizes.spaceBtwSections),
              itemBuilder: (_, index) {
                // Only wrap the item widget in Obx if 'order.items[index]' is reactive.

                final item = order.items[index];
                return Column(
                  children: [
                    TCartItem(cartItem: item),
                  ],
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => NavigationScreen(
                      order.shippingAddress!.Lat, order.shippingAddress!.Long)),
                  child: const Text('Order Detail')),
            )
          ],
        ),
      ),
    );
  }
}
