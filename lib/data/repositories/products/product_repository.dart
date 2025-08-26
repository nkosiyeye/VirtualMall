
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_store/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/vendor_model.dart';

class ProductRepository extends GetxController{
  static ProductRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all products

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Step 1: Fetch the products that are featured
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();

      // Step 2: For each product, fetch the corresponding vendor details and map them to the ProductModel
      final productList = await Future.wait(
        snapshot.docs.map((document) async {
          // Convert document to ProductModel
          final product = ProductModel.fromSnapshot(document);

          // Fetch vendor details using vendorId
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          // Check if the vendor document exists
          if (vendorSnapshot.exists) {
            // Convert vendor document to VendorModel
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);

            // Assign the fetched vendor to the product
            product.vendor = vendor;
          }

          // Return the product with the vendor details
          return product;
        }).toList(),
      );

      // Return the list of products with vendor details
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  Future<List<ProductModel>> getProducts() async {
    try {
      // Step 1: Fetch the products that are featured
      final snapshot = await _db.collection('Products').get();

      // Step 2: For each product, fetch the corresponding vendor details and map them to the ProductModel
      final productList = await Future.wait(
        snapshot.docs.map((document) async {
          // Convert document to ProductModel
          final product = ProductModel.fromSnapshot(document);

          // Fetch vendor details using vendorId
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          // Check if the vendor document exists
          if (vendorSnapshot.exists) {
            // Convert vendor document to VendorModel
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);

            // Assign the fetched vendor to the product
            product.vendor = vendor;
          }

          // Return the product with the vendor details
          return product;
        }).toList(),
      );

      // Return the list of products with vendor details
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  /// Get all products
  Future<List<ProductModel>> getAllFeaturedProducts() async{
    try{
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();

      // Step 2: For each product, fetch the corresponding vendor details and map them to the ProductModel
      final productList = await Future.wait(
        snapshot.docs.map((document) async {
          // Convert document to ProductModel
          final product = ProductModel.fromSnapshot(document);

          // Fetch vendor details using vendorId
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          // Check if the vendor document exists
          if (vendorSnapshot.exists) {
            // Convert vendor document to VendorModel
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);

            // Assign the fetched vendor to the product
            product.vendor = vendor;
          }

          // Return the product with the vendor details
          return product;
        }).toList(),
      );
      return productList;
    }on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }catch(e){
      print(e.toString());
      throw e.toString();
    }
  }
  /// Get all products
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      // Step 1: Fetch the products based on the query
      final querySnapshot = await query.get();

      // Step 2: For each product, fetch the corresponding vendor details and map them to the ProductModel
      final List<ProductModel> productList = await Future.wait(
        querySnapshot.docs.map((doc) async {
          // Convert document to ProductModel
          final product = ProductModel.fromQuerySnapshot(doc);

          // Fetch vendor details using vendorId
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          // Check if the vendor document exists
          if (vendorSnapshot.exists) {
            // Convert vendor document to VendorModel
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);

            // Assign the fetched vendor to the product
            product.vendor = vendor;
          }

          // Return the product with the vendor details
          return product;
        }).toList(),
      );

      // Return the list of products with vendor details
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<ProductModel>> getFavoriteProducts(List<String> productIds) async {
    try {
      // Step 1: Fetch the products by product IDs
      final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      // Step 2: For each product, fetch the corresponding vendor details
      final productList = await Future.wait(
        snapshot.docs.map((doc) async {
          final product = ProductModel.fromQuerySnapshot(doc);
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          if (vendorSnapshot.exists) {
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);
            product.vendor = vendor;
          }

          return product;
        }).toList(),
      );

      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).get()
          : await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).limit(limit).get();

      final productList = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final product = ProductModel.fromSnapshot(doc);
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          if (vendorSnapshot.exists) {
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);
            product.vendor = vendor;
          }

          return product;
        }).toList(),
      );

      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<ProductModel>> getSearched(String searchTerm) async {
    try {
      final querySnapshot = await _db.collection('Products')
          .where('Title', arrayContains: searchTerm).get();

      final productList = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final product = ProductModel.fromSnapshot(doc);
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          if (vendorSnapshot.exists) {
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);
            product.vendor = vendor;
          }
          return product;
        }).toList(),
      );

      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = -1}) async {
    try {
      // Step 1: Fetch the product IDs associated with the category
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();
      if(productIds.isNotEmpty){
        // Step 2: Fetch the products using the product IDs
        final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

        // Step 3: For each product, fetch the corresponding vendor details
        final productList = await Future.wait(
          productsQuery.docs.map((doc) async {
            final product = ProductModel.fromSnapshot(doc);
            final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

            if (vendorSnapshot.exists) {
              final vendor = VendorModel.fromSnapshot(vendorSnapshot);
              product.vendor = vendor;
            }

            return product;
          }).toList(),
        );

        return productList;
      }else{
        return [];
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<ProductModel>> getProductsForVendor({required String vendorId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db.collection('Products').where('VendorId', isEqualTo: vendorId).get()
          : await _db.collection('Products').where('VendorId', isEqualTo: vendorId).limit(limit).get();

      final productList = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final product = ProductModel.fromSnapshot(doc);
          final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();

          if (vendorSnapshot.exists) {
            final vendor = VendorModel.fromSnapshot(vendorSnapshot);
            product.vendor = vendor;
          }

          return product;
        }).toList(),
      );

      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

/// Get Sun Categories
}