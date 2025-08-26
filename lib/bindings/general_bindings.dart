

import 'package:flutter_store/features/personalization/controllers/address_controller.dart';
import 'package:flutter_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:flutter_store/features/shop/controllers/product/variation_controller.dart';
import 'package:flutter_store/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}