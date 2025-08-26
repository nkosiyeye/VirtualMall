import 'package:flutter_store/data/repositories/products/product_repository.dart';
import 'package:flutter_store/features/shop/models/product_model.dart';
import 'package:flutter_store/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/Vendors/Vendors_repository.dart';
import '../models/Vendor_model.dart';

class VendorController extends GetxController{
  static VendorController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<VendorModel> allVendors = <VendorModel>[].obs;
  final RxList<VendorModel> featuredVendors = <VendorModel>[].obs;
  final vendorRepository = Get.put(VendorsRepository());

  @override
  void onInit() {
    getFeaturedVendors();
    super.onInit();
  }

  /// -- Load Brands
  Future<void> getFeaturedVendors() async{
    try{
      // Show loader while loading Brands
      isLoading.value = true;
      final vendors = await vendorRepository.getAllVendors();
     allVendors.assignAll(vendors);

      featuredVendors.assignAll(allVendors.where((vendor) => vendor.isFeatured ?? false).take(4));

    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      // Stop loader
      isLoading.value = false;
    }

  }
  /// -- Get Brands for Category
  Future<List<Object>> getVendorsForCategory(String categoryId) async{
    try{
      final vendors = await vendorRepository.getVendorsForCategory(categoryId);
      return vendors;
    }catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getVendorProducts({required String vendorId, int limit = -1}) async{
    try{
      final products =
      await ProductRepository.instance.getProductsForVendor(vendorId: vendorId, limit: limit);
      return products;
    }catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}