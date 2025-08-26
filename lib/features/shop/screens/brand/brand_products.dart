import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/common/widgets/brands/t_brand_card.dart';
import 'package:flutter_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:flutter_store/features/shop/controllers/brand_controller.dart';
import 'package:flutter_store/features/shop/models/brand_model.dart';
import 'package:flutter_store/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              TBrandCard(showBoarder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections,),
              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id,),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;
                  // Products found
                  final products = snapshot.data!;
                  return TSortableProducts(products: products);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
