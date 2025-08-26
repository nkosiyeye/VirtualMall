import 'package:flutter/material.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../models/order_model.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
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
          const SizedBox(height: TSizes.spaceBtwSections,),
          TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            backgroundColor: TColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: Theme.of(context).textTheme.titleLarge,),
                    Text('E${subTotal.toStringAsFixed(1)}', style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount', style: Theme.of(context).textTheme.titleLarge,),
                    Text('E0.00', style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping', style: Theme.of(context).textTheme.titleLarge,),
                    Text('E${TPricingCalculator.calculateShippingCost(subTotal, '')}', style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge,),
                    Text('E${TPricingCalculator.calculateTax(subTotal, '')}', style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.titleLarge,),
                    Text('E${TPricingCalculator.calculateTotalPrice(subTotal, '')}', style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
