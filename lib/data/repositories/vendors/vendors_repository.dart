

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_store/utils/exceptions/format_exceptions.dart';
import 'package:flutter_store/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/Vendor_model.dart';

class VendorsRepository extends GetxController{
  static VendorsRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all Vendors
  Future<List<VendorModel>> getAllVendors() async{
    try{
      final snapshot = await _db.collection('vendors').get();
      final result = snapshot.docs.map((documentSnapshot) => VendorModel.fromSnapshot(documentSnapshot)).toList();
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
  /// Get Vendors for category to be implemented
  Future<List<VendorModel>> getVendorsForCategory(String categoryId) async{
    try{
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot vendorCategoryQuery = await _db.collection('VendorCategory').where('categoryId', isEqualTo: categoryId).get();

      // Extract VendorIds from the documents
      List<String> vendorIds = vendorCategoryQuery.docs.map((doc) => doc['VendorId'] as String).toList();

      // Query to get all documents where the VendorId is in the list of VendorIds, FieldPath.documentId to query documents in collection
      final  vendorsQuery = await _db.collection('vendors').where(FieldPath.documentId, whereIn: vendorIds).limit(2).get();

      // Extract Vendor names or other relevant data from the documents
      List<VendorModel> vendors = vendorsQuery.docs.map((doc) => VendorModel.fromSnapshot(doc)).toList();
      return vendors;
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