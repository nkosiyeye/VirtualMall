import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/features/personalization/controllers/update_name_controller.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/constants/text_strings.dart';
import 'package:flutter_store/utils/validators/validators.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Custom AppBar
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          /// Headings
            children: [
              Text(
                'Use real name for easy verification. This name will  appear on several pages.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),

              /// Text field and Button
              Form(
                key: controller.updateUserNameFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) => TValidator.validateEmptyText('First Name', value),
                        expands: false,
                        decoration: const InputDecoration(labelText: TTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields,),
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) => TValidator.validateEmptyText('Last Name', value),
                        expands: false,
                        decoration: const InputDecoration(labelText: TTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              
              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save'),),
              )
            ],
        ),
      ),
    );
  }
}
