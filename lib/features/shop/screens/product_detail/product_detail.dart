import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/texts/section_heading.dart';
import 'package:flutter_store/features/shop/models/product_model.dart';
import 'package:flutter_store/features/shop/screens/product_detail/widgets/bottom_add_to_cart_widget.dart';
import 'package:flutter_store/features/shop/screens/product_detail/widgets/product_attributes.dart';
import 'package:flutter_store/features/shop/screens/product_detail/widgets/product_detail_image_slider.dart';
import 'package:flutter_store/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:flutter_store/features/shop/screens/product_detail/widgets/rating_share_widget.dart';
import 'package:flutter_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:flutter_store/features/shop/screens/vendor/vendor.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../product_reviews/widgets/rating_progress_indicator.dart';
import '../product_reviews/widgets/user_review_card.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            TProductImageSlider(product: product),
            /// Product Details
            Padding(
                padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
                child: Column(
                  children: [
                      /// - Rating & Share Button
                    const TRatingAndShare(),
                    /// Title, Price, Stock and Brand
                    TProductMetaData(product: product),
                    /// Attributes
                    if(product.productType == ProductType.variable.toString()) TProductAttributes(product: product,),
                    if(product.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwSections,),
                    /// --- Checkout Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: const Text("Checkout"))),
                    const SizedBox(height: TSizes.spaceBtwSections,),

                    /// Description
                    const TSectionHeading(title: 'Description', showActionButton: false,),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    ReadMoreText(
                      product.description ?? '',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Less',
                      moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: TColors.primary),
                      lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: TColors.primary),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        GestureDetector(
                          onTap: () => Get.to(() => VendorProducts(vendor: product.vendor!)),
                          child: Row(
                            children: [
                              product.vendor!.thumbnail != '' ? CircleAvatar(backgroundImage: NetworkImage(product.vendor!.thumbnail))
                                  : const CircleAvatar(backgroundImage: AssetImage(TImages.storeLogo)),
                              const SizedBox(width: TSizes.spaceBtwItems,),
                              Text(product.vendor!.storeName, style: Theme.of(context).textTheme.titleLarge,),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                      ],
                    ),

                    /// -- Reviews
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TSectionHeading(title: 'Reviews(199)',showActionButton: false,),
                        IconButton(onPressed: () => Get.to(() => const ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 18,))
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    /// Reviews
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ratings and reviews are verified and are from people who use the same type of device that you use."),
                        const SizedBox(height: TSizes.spaceBtwItems,),

                        /// Overall Product Ratings
                        const TOverallProductRating(),
                        const TRatingBarIndicator(rating: 4,),
                        Text('100', style: Theme.of(context).textTheme.bodySmall,),
                        const SizedBox(height: TSizes.spaceBtwSections,),
                        /// User Review Card
                        const UserReviewCard(),

                      ],
                    ),
                  ],
                ),
            )

          ],
        ),
      ),
    );
  }
}




