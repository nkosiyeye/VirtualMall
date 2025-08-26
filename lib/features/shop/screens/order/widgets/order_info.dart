import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../models/order_model.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(order.formattedOrderDate, style: Theme.of(context).textTheme.bodyLarge,),
                ],
              )
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('${order.items.length} items', style: Theme.of(context).textTheme.bodyLarge,),
                ],
              )
              ),
              Expanded(
                flex: 2 ,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TRoundedContainer(
                    radius: TSizes.cardRadiusSm,
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm,vertical: 0),
                    //backgroundColor: THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
                    child: DropdownButton<OrderStatus>(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      value: order.status,
                      onChanged: (OrderStatus? newValue){},
                      items: OrderStatus.values.map((OrderStatus status){
                        return DropdownMenuItem<OrderStatus>(
                          value: status,
                          child: Text(
                            status.name.capitalize.toString(),
                            //style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status)),
                          ),
                        );
                      }).toList(),
        
                      ),
                    ),
                ],
              )
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('E${order.totalAmount}', style: Theme.of(context).textTheme.bodyLarge,),
                ],
              )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
