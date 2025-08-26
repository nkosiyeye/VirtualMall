import 'package:flutter/material.dart';
import 'package:flutter_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:flutter_store/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:flutter_store/utils/validators/validators.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TSignupFrom extends StatelessWidget {
  const TSignupFrom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
      children: [
        /// First and Last name
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value) => TValidator.validateEmptyText('First Name', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value) => TValidator.validateEmptyText('Last Name', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.lastName, prefixIcon: Icon(Iconsax.user)),
              ),
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        /// Username
        TextFormField(
          controller: controller.username,
          validator: (value) => TValidator.validateEmptyText('Username', value),
          decoration: const InputDecoration(
              labelText: TTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        /// Email
        TextFormField(
          controller: controller.email,
          validator: (value) => TValidator.validateEmail(value),
          decoration: const InputDecoration(
              labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        /// Phone Number
        TextFormField(
          controller: controller.phoneNumber,
          validator: (value) => TValidator.validatePhoneNumber(value),
          decoration: const InputDecoration(
              labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        /// Password
        Obx(
          () => TextFormField(
            controller: controller.password,
            validator: (value) => TValidator.validatePassword(value),
            obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                )
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        /// Terms & Conditions
        const TTermsAndConditionCheckbox(),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        /// Sign up Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.signup(),
            child: const Text(TTexts.createAccount),
          ),
        )
      ],
    ));
  }
}
