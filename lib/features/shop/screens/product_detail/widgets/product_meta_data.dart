import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/images/t_circular_image.dart';
import 'package:flutter_store/common/widgets/texts/product_price_text.dart';
import 'package:flutter_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:flutter_store/features/shop/controllers/product/product_controller.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            if(product.salePrice > 0)
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('$salePercentage%',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
              ),
            ),

            if(product.salePrice > 0)
            const SizedBox(width: TSizes.spaceBtwItems,),

            /// Price
            if(product.productType == ProductType.single.toString() && product.salePrice > 0)
            Text('E${product.price}', style: Theme.of(context).textTheme.bodySmall!.apply(decoration: TextDecoration.lineThrough),),
            if(product.productType == ProductType.single.toString() && product.salePrice > 0) const SizedBox(width: TSizes.spaceBtwItems / 2,),
            TProductPriceText(price: controller.getProductPrice(product), isLarge: true,)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
        /// Title
        TProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),

        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: "Status:"),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),

        /// Brand
        Row(
          children: [
            TCircularImage(
              isNetworkImage: true,
                image: product.brand != null ? product.brand!.image : '',
                width: 32,
                height: 32,
                overlayColor: dark ? TColors.textWhite : TColors.black,),
            TBrandTitleWithVerificationIcon(title: product.brand != null ? product.brand!.name : '', brandTextSizes: TextSizes.medium,),
          ],
        )
      ],
    );
  }
}
