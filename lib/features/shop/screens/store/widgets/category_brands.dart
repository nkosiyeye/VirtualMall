import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:flutter_store/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:flutter_store/features/shop/controllers/brand_controller.dart';
import 'package:flutter_store/features/shop/models/category_model.dart';
import 'package:flutter_store/utils/constants/sizes.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget{
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        /// Handle Loader, No Record, OR Error Message
        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        );
        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget != null) return const Column(children: []);

        /// Record Found
        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index){
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget != null) return const SizedBox.shrink();

                final products = snapshot.data!;
                return TBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
              }
            );
          }
        );
      }
    );
  }

}