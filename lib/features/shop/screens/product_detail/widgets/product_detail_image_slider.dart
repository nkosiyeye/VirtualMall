import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/images_controller.dart';
import '../../../models/product_model.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    return TCustomEdgeWidget(
      child: Container(
        color: dark ? TColors.black : TColors.textWhite,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Center(
                child: Obx(
                        (){
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            imageUrl: image,
                            progressIndicatorBuilder: (_, __, downloadProgress) =>
                                SizedBox(height:40, width: 40,child: CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary,))
                        ),
                      );
                    }),
              ),
            ),
            /// Image Slider
            Positioned(
              right: 0,
              bottom: 25,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, index) => const SizedBox(width: TSizes.spaceBtwItems,),
                  itemBuilder: (_, index) => Obx(
                      () {
                        final imageSelected = controller.selectedProductImage.value == images[index];
                        return TRoundedImage(
                            width: 80,
                            backgroundColor: dark ? TColors.black : TColors.textWhite,
                            border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                            isNetworkImage: true,
                            imageUrl: images[index],
                          onPressed: () => controller.selectedProductImage.value = images[index],
                        );

                      }
                  ),
                ),
              ),
            ),

            /// Appbar Icons
            TAppBar(
              showBackArrow: true,
              actions: [TFavouriteIcon(productId: product.id)],
            )
          ],
        ),
      ),
    );
  }
}