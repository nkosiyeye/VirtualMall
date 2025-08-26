

import 'package:flutter_store/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter_store/features/shop/controllers/product/images_controller.dart';
import 'package:flutter_store/features/shop/models/product_model.dart';
import 'package:flutter_store/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variable
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel
      .empty()
      .obs;

  /// --- Select Attribute and Variation
  void onAttributeSelected(ProductModel product, attributeName,
      attributeValue) {
    // when attribute is selected we will first add that attribute to the selectedAttributes
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
          (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
          orElse: () => ProductVariationModel.empty());

    // Show the selected Variation Image as a Main Image
    if(selectedVariation.image.isNotEmpty){
      ImagesController.instance.selectedProductImage.value = selectedVariation.image;
    }
    // Show Selected variation quantity already in the cart.
    if(selectedVariation.id.isNotEmpty){
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Assign Selected Variation
    this.selectedVariation.value = selectedVariation;

    // Update selected product variation status
    getProductVariationStockStatus();
  }
  /// -- Check if selected attributes matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){
    // if selectedAttributes contains 3 attributes and current variation contains 2 then return.
    if(variationAttributes.length != selectedAttributes.length) return false;

    // if any of the attributes is different then return e.g. [Green, Large] x [Green, Small]
    for(final key in variationAttributes.keys){
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  /// -- Check Attribute availability / Stock in Variation
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variation, String attributeName) {
    // Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributionValues = variation
        .where((variation) =>
    // Check Empty / Out of Stock Attributes
      variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0
    ).map((variation) => variation.attributeValues[attributeName]).toSet();
    return availableVariationAttributionValues;
  }

  /// -- Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }
  String getVariationPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  /// -- Reset Selected Attributes when switching product
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

}
