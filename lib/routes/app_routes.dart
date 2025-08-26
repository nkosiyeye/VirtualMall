
import 'package:flutter_store/features/shop/screens/store/store.dart';
import 'package:flutter_store/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: TRoutes.store, page: () => const StoreScreen())
  ];
}