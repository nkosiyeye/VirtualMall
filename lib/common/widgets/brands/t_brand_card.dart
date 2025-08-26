import 'package:flutter/material.dart';
import 'package:flutter_store/features/shop/models/brand_model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/t_circular_image.dart';
import '../texts/t_brand_title_text_with_verified_icon.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, required this.showBoarder, this.onTap, required this.brand,
  });
  final BrandModel brand;
  final void Function()? onTap;
  final bool showBoarder;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBoarder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// --- Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? TColors.textWhite : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2,),
            /// --- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerificationIcon(title: brand.name, brandTextSizes: TextSizes.large,),
                  Text('${brand.productsCount ?? 0} products', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelMedium,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}