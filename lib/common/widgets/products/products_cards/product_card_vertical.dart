import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_store/common/widgets/images/t_rounded_image.dart';
import 'package:flutter_store/features/shop/controllers/product/product_controller.dart';
import 'package:flutter_store/features/shop/screens/product_detail/product_detail.dart';
import 'package:flutter_store/common/style/shadows.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../icons/t_circular_icon.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../cart/product_card_add_to_cart_button.dart';
import '../favourite_icon/favourite_icon.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product,)),
      child: Container(
        width: 180,
        //height: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkerGrey : TColors.textWhite),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(0),
              backgroundColor: dark ? TColors.black : TColors.light,
              child: Stack(
                children: [
                  /// --- Thumbnail Image
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.thumbnail,
                      width: 180,
                      height: 180,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
      
                  /// -- Sale Tag
                  if(salePercentage != null)
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),
      
                  /// --- Favourite Icon Button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: TFavouriteIcon(productId: product.id)),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2,),
      
            /// --- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: product.title, smallSize: true, maxLines: 1,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2,),
                  TBrandTitleWithVerificationIcon(title: product.brand!.name),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: Text(product.price.toString(),
                              style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),),
                          ),

                        Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: TProductPriceText(price: controller.getProductPrice(product)),
                        ),
                      ],
                    ),
                  ),
                ),
                /// Add to Cart Button
                ProductCardAddToCartButton(product: product,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}










