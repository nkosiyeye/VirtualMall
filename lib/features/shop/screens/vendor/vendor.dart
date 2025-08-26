import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:flutter_store/features/shop/controllers/vendor_controller.dart';
import 'package:flutter_store/features/shop/models/vendor_model.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class VendorProducts extends StatelessWidget {
  const VendorProducts({super.key, required this.vendor});

  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorController());
    return Scaffold(
      appBar: TAppBar(title: Text(vendor.storeName), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              //TBrandCard(showBoarder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections,),
              FutureBuilder(
                  future: controller.getVendorProducts(vendorId: vendor.id),
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
