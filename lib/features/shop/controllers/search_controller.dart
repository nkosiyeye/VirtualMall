import 'package:flutter_store/features/shop/controllers/product/product_controller.dart';
import 'package:get/get.dart';

import '../../../data/repositories/products/product_repository.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../models/product_model.dart';

class CustomSearchController extends GetxController {
  var controller = ProductController.instance;
  var searchText = ''.obs;
  var filteredProduct = <ProductModel>[].obs;
  var recentSearches = <String>[].obs;

  // Search filters
  var isRentSelected = true.obs;
  var selectedPropertyType = ''.obs;
  var minPrice = 0.obs;
  var maxPrice = 0.obs;
  var postedSince = ''.obs;
  var selectedLocation = ''.obs;
  final ProductRepository productRepository = ProductRepository();


  //var searchText = ''.obs;
  //var recentSearches = <String>[].obs;

  // Replace with real data source
  var allProduct = <ProductModel>[].obs;
  @override
  void onInit() {
    loadProperties();
    super.onInit();
    debounce(searchText, (_) => performSearch(), time: const Duration(milliseconds: 500));
  }
  Future<void> performSearch() async {
    if (searchText.value.isEmpty) {
      filteredProduct.clear();
      return;
    }

    try {
      //final results = await productRepository.getSearched(searchText.value);
      filteredProduct.assignAll(allProduct.where((item) => item.title.toLowerCase().contains(searchText.value.toLowerCase())));

      // Add to recent searches
      if (!recentSearches.contains(searchText.value)) {
        recentSearches.add(searchText.value);
      }
    } catch (e) {
      print('Error during search: $e');
    }
  }

  void clearFilter() {
    isRentSelected.value = false;
    selectedPropertyType.value = '';
    minPrice.value = 0;
    maxPrice.value = 1000000;
    selectedLocation.value = '';
  }



  void loadRecentSearches() {
    final savedSearches = TLocalStorage.instance().readData('recentSearches') ?? [];
    recentSearches.assignAll(savedSearches.cast<String>());
  }

  void removeRecent(String search) {
    recentSearches.remove(search);
    saveRecentSearches(); // Update local storage
  }

  void saveRecentSearches() {
    // Ensure only the latest 5 searches are saved
    if (recentSearches.length > 5) {
      recentSearches.removeAt(0); // Remove the oldest search
    }
    TLocalStorage.instance().saveData('recentSearches', recentSearches.toList());
  }

  // Simulate loading from a backend or local DB
  void loadProperties() async {
    var properties = await productRepository.getProducts();
    allProduct.assignAll(properties);
  }

  void clearSearch() {
    searchText.value = '';
  }
}
