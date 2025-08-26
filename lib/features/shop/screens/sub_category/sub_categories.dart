import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/common/widgets/images/t_rounded_image.dart';
import 'package:flutter_store/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:flutter_store/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:flutter_store/common/widgets/texts/section_heading.dart';
import 'package:flutter_store/features/shop/controllers/category_controller.dart';
import 'package:flutter_store/features/shop/models/category_model.dart';
import 'package:flutter_store/features/shop/screens/all_products/all_products.dart';
import 'package:flutter_store/utils/constants/image_strings.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Banner
                /// Uncomment the below line to show a banner image To do
                //const TRoundedImage(width: double.infinity , height: 200 ,imageUrl: TImages.promoBanner1, applyImageRadius: true,),
                //const SizedBox(height: TSizes.spaceBtwSections,),
                
                /// Sub categories
                FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = THorizontalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if(widget != null) return widget;

                    final subCategories = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index){
                        final subCategory = subCategories[index];
                          return FutureBuilder(
                            future: controller.getCategoryProducts(categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                              if(widget != null) return widget;

                              final products = snapshot.data!;
                              return Column(
                                children: [
                                  /// Heading
                                  TSectionHeading(title: subCategory.name, onPressed: () => Get.to(
                                      () => AllProducts(
                                          title: subCategory.name,
                                        futureMethod: controller.getCategoryProducts(categoryId: subCategory.id, limit: -1),
                                      )
                                  ),),
                                  const SizedBox(height: TSizes.spaceBtwItems / 2,),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems,),
                                      itemBuilder: (context, index) => TProductCardHorizontal(product: products[index]),
                                    ),
                                  ),
                                ],
                              );
                            }
                          );

                        },
                    );
                  }
                )
              ],
            ),
        ),
      ),
    );
  }
}
