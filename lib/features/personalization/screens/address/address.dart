import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/features/personalization/controllers/address_controller.dart';
import 'package:flutter_store/features/personalization/screens/address/add_new_address.dart';
import 'package:flutter_store/features/personalization/screens/address/map_screen.dart';
import 'package:flutter_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
          onPressed: () => Get.to(() =>
          const GoogleMapPage()
          //const AddNewAddressScreen()
          ),
        child: const Icon(Iconsax.add, color: TColors.textWhite,),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() => FutureBuilder(
                  // Use key to trigger refresh
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.allUserAddresses(),
                  builder: (context, snapshot) {

                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(widget != null) return widget;

                    final addresses = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (_, index) => TSingleAddress(
                          address: addresses[index],
                          onTap: () => controller.selectAddress(addresses[index])),
                    );
                  }
                ),
          ),
          ),
        ),
      );
  }
}
