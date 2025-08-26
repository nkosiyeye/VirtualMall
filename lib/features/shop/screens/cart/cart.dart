import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:flutter_store/features/shop/screens/checkout/checkout.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true,),
      body: Obx(() {

        /// Nothing found
        final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops Cart is Empty...',
            animation: TImages.cartAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu())
        );

            if (controller.cartItems.isEmpty) {
              return emptyWidget;
            } else {
              return const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                
                  /// -- Items in Cart
                  child: TCartItems()
                            ),
              );
            }
          }
      ),
      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
        ? const SizedBox()
        : Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
          onPressed: ()=> Get.to(() => const CheckoutScreen()),
          child: Obx(() => Text('Checkout E${controller.totalCartPrice.value}')),),
      ),
    );
  }
}




