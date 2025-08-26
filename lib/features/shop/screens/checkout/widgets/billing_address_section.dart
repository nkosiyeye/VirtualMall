import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/texts/section_heading.dart';
import 'package:flutter_store/features/personalization/controllers/address_controller.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () => addressController.selectNewAddressPopup(context)),
        addressController.selectedAddress.value.id.isNotEmpty ?
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(addressController.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  const Icon(Iconsax.mobile, color: Colors.grey, size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Text(addressController.selectedAddress.value.formattedPhoneNo, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  const Icon(Iconsax.location, color: Colors.grey, size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: Text(addressController.selectedAddress.value.toString(), style: Theme.of(context).textTheme.bodyMedium, softWrap: true,)),
                ],
              ),
            ],
          ),
        ): Text('Select Address', style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
