import 'package:flutter_store/utils/service/notification_service.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/orders/order_repository.dart';
import '../../../../data/repositories/user/user_respository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/order_model.dart';
import 'navigation_screen.dart';

class DeliveryController extends GetxController{
  static DeliveryController get instance => Get.find();

  /// Variables
  final orderRepository = Get.put(OrderRepository());
  RxBool loading = true.obs;
  RxBool startDeliveryLoading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  RxBool refreshData = true.obs;
  final userRepository = Get.put(UserRepository());

  NotificationService notificationService = NotificationService();

  /// Fetch user's order history
  Future<List<OrderModel>> fetchOrders() async{
    try{
      final userOrders = await orderRepository.fetchAllOrders();
      return userOrders;
    }catch (e){
      TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }
  Future<void> getCustomerOfCurrentOrder() async{
    try{
      loading.value = true;
      final user = await userRepository.fetchUserDetails(order.value.userId);

      customer.value = user;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      loading.value = false;
    }
  }

  Future<void> updateUserNotification() async{
    try{
      startDeliveryLoading.value = true;
      final user = await userRepository.fetchUserDetails(order.value.userId);
      print(user.fcmToken);
      await notificationService.sendPushNotification(targetToken: user.fcmToken, title: 'Smart Trolley', body: "Your order is on the way.");
      TLoaders.successSnackBar(title: 'Success', message: 'Notification updated successfully');
      Get.to(() => NavigationScreen(order.value.shippingAddress!.Lat, order.value.shippingAddress!.Long));
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      startDeliveryLoading.value = false;
    }
  }

}