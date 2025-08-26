


import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel{
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount
  });

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');


  /// Convert model to Json structure so that you can store data in firebase
  toJson(){
    return{
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured
    };
  }
  factory BrandModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: data['ProductsCount'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false
    );
  }
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data();
    if(data == null) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: data['ProductsCount'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false
    );
  }
}