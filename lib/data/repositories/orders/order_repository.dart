import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current user
  Future<List<OrderModel>> fetchUserOrders() async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information. Try again in a few minutes';

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot) => OrderModel.fromDocumentSnapshot(documentSnapshot)).toList();

    }catch (e){
      print(e.toString());
      throw 'Something went wrong whilte fetching Order Information. Try again later';
      print(e.toString());
    }
  }

  /// Store new user address
  Future<String> addOrder(OrderModel order) async{
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentOrder = await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
      await _db.collection('Orders').add(order.toJson());
      return currentOrder.id;

    }catch (e){
      print(e.toString());
      throw 'Something went wrong while saving Address Information. Try again later';
    }
  }

  Future<List<OrderModel>> fetchAllOrders() async{
    try{
      final snapshot = await _db.collection('Orders').orderBy('orderDate', descending: true).get();
      final list = snapshot.docs.map((document) => OrderModel.fromSnapshot(document)).toList();
      return list;
    }on FirebaseException catch(e){
      throw e.code;
    }on PlatformException catch(e){
      throw e.code;
    }catch(e){
      print(e.toString());
      throw 'Something went wrong. Please try again';
    }
  }
}