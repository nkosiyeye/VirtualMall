

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_store/features/personalization/models/address_model.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/helpers/helper_functions.dart';

import 'cart_item_model.dart';

class OrderModel{
  final String docId;
  final String orderId;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel?  shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.orderId,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = 'Cash',
    this.shippingAddress,
    this.billingAddress,
    this.billingAddressSameAsShipping = true,
    this.deliveryDate,
  });
  static OrderModel empty() =>
      OrderModel(orderId: '',
          status: OrderStatus.pending,
          items: [],
          totalAmount: 0.0,
          shippingCost: 0.0,
          taxCost: 0.0,
          orderDate: DateTime.now()
      );

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!) : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  Map<String, dynamic> toJson(){
    return{
      "orderId": orderId,
      "userId": userId,
      "status": status.toString(),
      "totalAmount": totalAmount,
      "shippingCost": shippingCost,
      "taxCost": taxCost,
      "orderDate": orderDate,
      "paymentMethod": paymentMethod,
      "shippingAddress": shippingAddress!.toJson(),
      "billingAddress": billingAddress!.toJson(),
      "billingAddressSameAsShipping": billingAddressSameAsShipping,
      "deliveryDate": deliveryDate,
      "items": items.map((item) => item.toJson()).toList()

    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> data){
    return OrderModel(
      orderId: data.containsKey('orderId') ? data['orderId'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status') ? OrderStatus.values.firstWhere((element) => element.toString() == data['status']) : OrderStatus.pending,
      totalAmount: data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      shippingCost: data.containsKey('shippingCost') ? data['shippingCost'] as double : 0.0,
      taxCost: data.containsKey('taxCost') ? data['taxCost'] as double : 0.0,
      orderDate: data.containsKey('orderId') ? (data['orderDate'] as Timestamp).toDate() : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod') ? data['paymentMethod'] as String : '',
      shippingAddress: data.containsKey('shippingAddress') ? AddressModel.fromMap(data['shippingAddress'] as Map<String, dynamic>) : AddressModel.empty() ,
      billingAddress: data.containsKey('billingAddress') ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>) : AddressModel.empty() ,
      deliveryDate: data.containsKey('deliveryDate') ? data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate() : DateTime.now(),
      items: data.containsKey('items') ? (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList() : [],
    );
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      docId: snapshot.id,
      orderId: data.containsKey('orderId') ? data['orderId'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status') ? OrderStatus.values.firstWhere((element) => element.toString() == data['status']) : OrderStatus.pending,
      totalAmount: data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      shippingCost: data.containsKey('shippingCost') ? data['shippingCost'] as double : 0.0,
      taxCost: data.containsKey('taxCost') ? data['taxCost'] as double : 0.0,
      orderDate: data.containsKey('orderId') ? (data['orderDate'] as Timestamp).toDate() : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod') ? data['paymentMethod'] as String : '',
      shippingAddress: data.containsKey('shippingAddress') ? AddressModel.fromMap(data['shippingAddress'] as Map<String, dynamic>) : AddressModel.empty() ,
      billingAddress: data.containsKey('billingAddress') ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>) : AddressModel.empty() ,
      deliveryDate: data.containsKey('deliveryDate') ? data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate() : DateTime.now(),
      items: data.containsKey('items') ? (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList() : [],
    );
  }

  factory OrderModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      docId: snapshot.id,
      orderId: data.containsKey('orderId') ? data['orderId'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status') ? OrderStatus.values.firstWhere((element) => element.toString() == data['status']) : OrderStatus.pending,
      totalAmount: data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      shippingCost: data.containsKey('shippingCost') ? data['shippingCost'] as double : 0.0,
      taxCost: data.containsKey('taxCost') ? data['taxCost'] as double : 0.0,
      orderDate: data.containsKey('orderId') ? (data['orderDate'] as Timestamp).toDate() : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod') ? data['paymentMethod'] as String : '',
      shippingAddress: data.containsKey('shippingAddress') ? AddressModel.fromMap(data['shippingAddress'] as Map<String, dynamic>) : AddressModel.empty() ,
      billingAddress: data.containsKey('billingAddress') ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>) : AddressModel.empty() ,
      deliveryDate: data.containsKey('deliveryDate') ? data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate() : DateTime.now(),
      items: data.containsKey('items') ? (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList() : [],
    );
  }
}
