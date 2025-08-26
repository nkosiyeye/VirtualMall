

import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/texts/section_heading.dart';
import 'package:flutter_store/data/repositories/address/address_repository.dart';
import 'package:flutter_store/features/personalization/models/address_model.dart';
import 'package:flutter_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter_store/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../screens/address/map_screen.dart';
import 'package:uuid/uuid.dart';

class AddressController extends GetxController{
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  late final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final lat = TextEditingController();
  final long = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch All user specific Addresses
  Future<List<AddressModel>> allUserAddresses() async{
    try{
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;

    }catch (e){
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async{
    try{
      Get.defaultDialog(
        title: '',
        onWillPop: () async {return false;},
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const TCircularLoader()
      );
      // Clear the "Selected" field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updatedSelectedField(selectedAddress.value.id, false);
      }
      // Assign selected Address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      // Set the "selected" field to true for the newly selected address
      await addressRepository.updatedSelectedField(selectedAddress.value.id, true);

      Get.back();
    }catch (e){
      TLoaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  /// Add new Address
  Future addNewAddresses() async{
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Storing Address', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!addressFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }
      // Save Address Data
      final address = AddressModel(
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          Lat: double.tryParse(lat.text.trim())!,
          Long: double.tryParse(long.text.trim())!,
          selectedAddress: true,
          id: const Uuid().v4(),
      );
      final id = await addressRepository.addAddress(address);

      // Update Selected Address status
      address.id = id;
      selectedAddress(address);

      // Remove Loader
      TFullScreenLoader.stopLoading(); // Close the dialog using the Navigator
      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Move to previous screen
      Navigator.of(Get.context!).pop();

    }catch(e){
      TFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }

  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows you to control the height of the modal
      builder: (_) {
        // Get the height of the screen and set the height of the modal to half of it
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          height: screenHeight * 0.5, // Set the height to half of the screen height
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(title: 'Select Address', showActionButton: false),
              Expanded( // Allows the ListView to take the remaining space and be scrollable
                child: FutureBuilder(
                  future: allUserAddresses(),
                  builder: (_, snapshot) {
                    /// Helper Function: Handle Loader, No Record, OR ERROR Message
                    final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if (response != null) return response;

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => TSingleAddress(
                        address: snapshot.data![index],
                        onTap: () async {
                          selectAddress(snapshot.data![index]);
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const GoogleMapPage()),
                  child: const Text('Add new address'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}