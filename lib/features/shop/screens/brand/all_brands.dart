import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/brands/t_brand_card.dart';
import 'package:flutter_store/features/shop/controllers/brand_controller.dart';
import 'package:flutter_store/features/shop/screens/brand/brand_products.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brands/brands_shimmer.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Dropdown
              DropdownButtonFormField(
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
                      .map((option) => DropdownMenuItem(value: option,child: Text(option)),
                  ).toList(),
                  onChanged: (value){}
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),

              /// -- Brands
              Obx(
                    () {
                  if(brandController.isLoading.value) return const TBrandsShimmer(itemCount: 10);

                  if(brandController.allBrands.isEmpty){
                    return Center(
                        child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                  }
                  return TGridLayout(
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      return TBrandCard(
                        showBoarder: true,
                        brand: brand,
                        onTap: () => Get.to(() => BrandProducts(brand: brand,)),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}