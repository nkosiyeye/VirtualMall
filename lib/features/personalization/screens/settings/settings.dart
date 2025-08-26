import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter_store/common/widgets/list_tiles/settings_menu_tiles.dart';
import 'package:flutter_store/common/widgets/texts/section_heading.dart';
import 'package:flutter_store/features/personalization/controllers/logout_controller.dart';
import 'package:flutter_store/features/personalization/screens/address/address.dart';
import 'package:flutter_store/features/personalization/screens/profile/profile.dart';
import 'package:flutter_store/features/shop/screens/order/order.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_title.dart';
import '../../../../utils/constants/colors.dart';
import '../../../shop/screens/cart/cart.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                      title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.textWhite),),),
                      const SizedBox(height: TSizes.spaceBtwItems/3,),

                    /// User Profile Card
                    TUserProfileTitle(onPressed: () => Get.to(() => const ProfileScreen()),),
                    const SizedBox(height: TSizes.spaceBtwSections,)
                  ],
                ),
            ),
            /// -- Body
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// -- Account Settings
                    const TSectionHeading(title: 'Account Settings', showActionButton: false,),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    TSettingMenuTile(icon: Iconsax.safe_home, title: "My Addresses", subTitle: "Set shopping delivery address", onTap: () => Get.to(() => const UserAddressScreen()),),
                    TSettingMenuTile(icon: Iconsax.shopping_cart, title: "My Cart", subTitle: "Add, remove products and move to checkout", onTap: () => Get.to(() => const CartScreen()),),
                    TSettingMenuTile(icon: Iconsax.bag_tick, title: "My Orders", subTitle: "In-progress and Completed orders", onTap: () => Get.to(() => const OrderScreen()),),
                    TSettingMenuTile(icon: Iconsax.bank, title: "Bank Account", subTitle: "Withdraw Balance to registered account", onTap: (){},),
                    TSettingMenuTile(icon: Iconsax.discount_shape, title: "My Coupon", subTitle: "List of all the discounted coupons", onTap: (){},),
                    TSettingMenuTile(icon: Iconsax.notification, title: "Notification", subTitle: "Set any kind of notification message", onTap: (){},),
                    TSettingMenuTile(icon: Iconsax.security_card, title: "Account Privacy", subTitle: "Manage data usage and connected accounts", onTap: (){},),
                    
                    /// -- App Settings
                    const SizedBox(height: TSizes.spaceBtwSections,),
                    const TSectionHeading(title: 'App Settings', showActionButton: false,),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    const TSettingMenuTile(icon: Iconsax.document_upload, title: "Load Data", subTitle: 'Upload Data to your Cloud Firebase'),
                    TSettingMenuTile(icon: Iconsax.location, title: "Geolocation", subTitle: 'Set recommendation based on location', trailing: Switch(value: true, onChanged: (value){}),),
                    TSettingMenuTile(icon: Iconsax.security, title: "Safe Mode", subTitle: 'Search result is safe for all ages', trailing: Switch(value: false, onChanged: (value){}),),
                    TSettingMenuTile(icon: Iconsax.image, title: "HD Image quality", subTitle: 'set image quality to be seen', trailing: Switch(value: false, onChanged: (value){}),),

                    /// -- Logout Button
                    const SizedBox(height: TSizes.spaceBtwSections,),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(onPressed: () => controller.logout(), child: const Text('Logout')
                        ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections,),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}


