import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/common/widgets/images/t_circular_image.dart';
import 'package:flutter_store/common/widgets/shimmer/shimmer.dart';
import 'package:flutter_store/common/widgets/texts/section_heading.dart';
import 'package:flutter_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:flutter_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter_store/utils/constants/image_strings.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage = controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                        return controller.imageUploading.value
                          ? const TShimmerEffect(width: 80, height: 80, radius: 80,)
                          : TCircularImage(
                          image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty,);
                      }),
                      TextButton(onPressed: () => controller.uploadProfileImage(), child: const Text('Change Profile Picture')),
                    ],
                  ),
                ),
                /// Details
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems,),

                const TSectionHeading(title: 'Profile Information', showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                
                TProfileMenu(title: 'Name', value: controller.user.value.fullName, onTap: () => Get.to(() => const ChangeName()),),
                TProfileMenu(title: 'username', value: controller.user.value.username, onTap: (){},),

                const SizedBox(height: TSizes.spaceBtwItems,),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems,),

                /// Heading Personal Info
                const TSectionHeading(title: 'Personal Information', showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwItems,),

                TProfileMenu(title: 'UserID', value: controller.user.value.id, icon: Iconsax.copy, onTap: (){},),
                TProfileMenu(title: 'E-mail', value: controller.user.value.email, onTap: (){},),
                TProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onTap: (){},),
                TProfileMenu(title: 'Gender', value: 'Male', onTap: (){},),
                TProfileMenu(title: 'DOB', value: '24/05/2023', onTap: (){},),

                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems,),

                Center(
                  child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Close Account', style: TextStyle(color: Colors.red),),
                  ),
                )

                
                
              ],
            )
        ),
      ),
    );
  }
}


