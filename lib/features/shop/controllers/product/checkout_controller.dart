import 'package:flutter_store/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:flutter_store/utils/constants/image_strings.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Cash', image: TImages.cash);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              children:[
                const TSectionHeading(title: 'Select Payment Method', showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwSections,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash', image: TImages.cash)),
                const SizedBox(height: TSizes.spaceBtwItems/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Mobile Money', image: TImages.mtn)),
                const SizedBox(height: TSizes.spaceBtwItems/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: TImages.visa)),
                const SizedBox(height: TSizes.spaceBtwItems/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: TImages.masterCard)),
                const SizedBox(height: TSizes.spaceBtwItems/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: TImages.paypal)),
                const SizedBox(height: TSizes.spaceBtwItems/2,),
                const SizedBox(height: TSizes.spaceBtwSections,)

              ]

            ),
          ),
        )
    );
    
  }
}