import 'package:flutter/material.dart';
import 'package:flutter_store/features/shop/controllers/all_products_controller.dart';
import 'package:flutter_store/features/shop/models/product_model.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
                .map((option) => DropdownMenuItem(value: option,child: Text(option)),
            ).toList(),
            value: controller.selectedSortOption.value,
            onChanged: (value){
              // sort products based on the selected option
              controller.sortProducts(value!);
            }
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Obx(() => TGridLayout(itemCount: controller.products.length, itemBuilder: (_, index) => TProductCardVertical(product: controller.products[index],)))
      ],
    );
  }
}