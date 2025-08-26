

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_store/utils/exceptions/format_exceptions.dart';
import 'package:flutter_store/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';

class BrandsRepository extends GetxController{
  static BrandsRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all brands
  Future<List<BrandModel>> getAllBrands() async{
    try{
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((documentSnapshot) => BrandModel.fromSnapshot(documentSnapshot)).toList();
      return result;
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    try{
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      // Extract brandIds from the documents
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();
      if(brandIds.isNotEmpty){

        // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in collection
        final  brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

        // Extract brand names or other relevant data from the documents
        List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
        return brands;
      }else{
        return [];
      }
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}