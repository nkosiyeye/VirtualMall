import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:flutter_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:flutter_store/features/shop/screens/all_products/all_products.dart';
import 'package:flutter_store/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:flutter_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:flutter_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/product/product_controller.dart';
import '../search/SearchScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// Header design
            TPrimaryHeaderContainer(
              child: Column(
                children: [

                  /// AppBar
                  const THomeAppBar(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// -- Searchbar
                  TSearchContainer(
                    text: 'Search in store',
                    onTap: () => Get.to(SearchScreen()),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// -- Categories
                  const Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [

                        /// Headings
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        /// Categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections,)
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [

                  /// --- Promo Slider
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  /// --- Heading
                  TSectionHeading(title: 'Popular Products',
                    onPressed: () => Get.to(() =>
                        AllProducts(
                          title: 'Popular Products',
                          query: FirebaseFirestore.instance.collection('Products').where('IsFeatured', isEqualTo: true).limit(6),
                          futureMethod: controller.fetchAllFeaturedProducts(),
                        )
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  /// -- Popular Products
                  Obx((){
                    if(controller.isLoading.value) return const TVerticalProductShimmer();
                    if(controller.featuredProducts.isEmpty){
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(itemCount: controller.featuredProducts.length, itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






