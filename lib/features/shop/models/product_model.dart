


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_store/features/shop/models/product_attribute_model.dart';
import 'package:flutter_store/features/shop/models/product_variation_model.dart';
import 'package:flutter_store/features/shop/models/vendor_model.dart';

import 'brand_model.dart';

class ProductModel{
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  String VendorId;
  VendorModel? vendor;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
    required this.VendorId,
    this.vendor
});

  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '', VendorId: '');

  /// Json Format
  toJson(){
    return{
      'SKU':sku,
      'Title':title,
      'Stock':stock,
      'Price':price,
      'Images':images ?? [],
      'Thumbnail':thumbnail,
      'SalePrice':salePrice,
      'IsFeatured':isFeatured,
      'CategoryId':categoryId,
      'Brand': brand != null ? brand!.toJson() : {},
      'Description':description,
      'ProductType':productType,
      'ProductAttributes':productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      'ProductVariations':productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
      'VendorId':VendorId
    };
  }


  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data();
    if(data == null) return ProductModel.empty();
    // Fetch vendor details
    /*VendorModel? vendor;
    if (data['VendorId'] != null && data['VendorId'].isNotEmpty) {
      final vendorSnapshot = await db.collection('Vendors').doc(data['VendorId']).get();
      if (vendorSnapshot.exists) {
        vendor = VendorModel.fromSnapshot(vendorSnapshot);
      }
    }*/
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : BrandModel.empty(),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null ? (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList() : [],
      productVariations: data['ProductVariations'] != null ? (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList() : [],
      VendorId: data['VendorId'] ?? '',
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document){
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null ? (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList() : [],
      productVariations: data['ProductVariations'] != null ? (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList() : [],
        VendorId: data['VendorId'] ?? ''
    );
  }
}