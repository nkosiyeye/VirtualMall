import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:flutter_store/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:get/get.dart'; // Assume it's saved separately

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(CustomSearchController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: TextField(
          onChanged: (val) => controller.searchText.value = val,
          decoration: InputDecoration(
            hintText: 'Search for product...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisSize: MainAxisSize.min, // You might not need this if using Expanded
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
                    () {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Center(
                      child: Text(
                        'Found: ${controller.filteredProduct.length.toString()} products',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  );
                }
            ),
            const SizedBox(height: 10), // Optional spacing
            Obx(
                  () {

                if (controller.filteredProduct.isEmpty) { // Assuming you have hasSearched
                  return const Center(child: Text('No products found.'));
                }
                return TGridLayout(itemCount: controller.filteredProduct.length, itemBuilder: (_, index) => TProductCardVertical(product:controller.filteredProduct[index]));
              },
            ),
          ],
        ),
      ),
    );
  }
}


