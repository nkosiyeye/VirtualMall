import 'package:flutter/material.dart';
import 'package:flutter_store/data/repositories/orders/order_repository.dart';
import 'package:flutter_store/features/personalization/controllers/address_controller.dart';
import 'package:flutter_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/helpers/pricing_calculator.dart';
import 'package:flutter_store/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;

  RxBool refreshData = true.obs;

  Future processOrder(double totalAmount) async {
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
      /*if(!addressFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }*/

      // Save Address Data
      final order = OrderModel(
          orderId: generateInvoiceId(),
          status: OrderStatus.processing,
          items: cartController.cartItems,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          shippingAddress: addressController.selectedAddress.value,
          billingAddress: addressController.selectedAddress.value,
          taxCost: TPricingCalculator.getTaxRateForLocation(addressController.country.value.text),
          shippingCost: TPricingCalculator.getShippingCost(addressController.country.value.text),
          userId: userId
      );
      await orderRepository.addOrder(order);

      // Remove Loader
      TFullScreenLoader.stopLoading(); // Close the dialog using the Navigator
      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your order has been saved successfully');

      cartController.clearCart();

      // Move to previous screen
      Navigator.of(Get.context!).pop();

    }catch(e){
      TFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }

  }

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    }catch (e){
        TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
        return [];
    }
  }
  String generateInvoiceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8); // Last few digits of timestamp
    final randomPart = (1000 + (9999 - 1000) * (DateTime.now().microsecond / 1000000)).toInt(); // Random 4-digit number
    return 'Ord-$timestamp$randomPart';
  }

}