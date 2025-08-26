import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/common/widgets/appbar/tabbar.dart';
import 'package:flutter_store/common/widgets/brands/brands_shimmer.dart';
import 'package:flutter_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:flutter_store/common/widgets/layouts/grid_layout.dart';
import 'package:flutter_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:flutter_store/features/shop/controllers/brand_controller.dart';
import 'package:flutter_store/features/shop/controllers/category_controller.dart';
import 'package:flutter_store/features/shop/screens/brand/all_brands.dart';
import 'package:flutter_store/features/shop/screens/search/SearchScreen.dart';
import 'package:flutter_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/brands/t_brand_card.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../brand/brand_products.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            TCartCounterIcon()
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.textWhite,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// --- Search bar
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TSearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                        onTap: () => Get.to(SearchScreen()),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      /// -- Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),

                      Obx(
                        () {
                          if(brandController.isLoading.value) return const TBrandsShimmer(itemCount: 4);

                          if(brandController.featuredBrands.isEmpty){
                            return Center(
                              child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                          }
                            return TGridLayout(
                              itemCount: brandController.featuredBrands.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                final brand = brandController.featuredBrands[index];
                                return TBrandCard(showBoarder: true,brand: brand,
                                    onTap: () => Get.to(() => BrandProducts(brand: brand,)));
                              },
                            );
                          },
                      ),
                    ],
                  ),
                ),
                /// Tabs
                bottom: TTabBar(
                  tabs: categories.map((category) => Tab(child: Text(category.name),)).toList()
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) => TCategoryTab(category: category,)).toList()
          ),
        ),
      ),
    );
  }
}



