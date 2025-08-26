import 'package:flutter/material.dart';
import 'package:flutter_store/features/shop/screens/delivery/delivery_controller.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../models/order_model.dart';
import 'package:get/get.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeliveryController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                () => Row(
                  children: [
                    TRoundedImage(
                      width: 50,
                        height: 50,
                        backgroundColor: TColors.primaryBackground,
                      imageUrl: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture :  TImages.user,
                      isNetworkImage: controller.customer.value.profilePicture.isNotEmpty,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.customer.value.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                             Text(
                              controller.customer.value.email,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections / 4,
        ),
        Obx(
    () => SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Person', style: Theme.of(context).textTheme.headlineSmall,),
                  const SizedBox(
                    height: TSizes.spaceBtwItems/2,
                  ),
                  Text(controller.customer.value.fullName, style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Text(controller.customer.value.email, style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Text( controller.customer.value.formattedPhoneNo.isNotEmpty
                      ? controller.customer.value.formattedPhoneNo
                      : '+(268)**** ****', style: Theme.of(context).textTheme.titleSmall,),
                 ],
              ),
            ),
          ),
        ),

        const SizedBox(
          height: TSizes.spaceBtwSections / 4,
        ),
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping Address', style: Theme.of(context).textTheme.headlineSmall,),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(order.shippingAddress != null
                    ? order.shippingAddress!.name
                    : '', style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Text(order.shippingAddress != null
                    ? order.shippingAddress!.toString()
                    : '', style: Theme.of(context).textTheme.titleSmall,),
                 ],
            ),
          ),
        ),
      ],
    );
  }
}
