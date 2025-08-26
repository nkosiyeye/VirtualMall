
class TPricingCalculator{

  /// --- Calculate Price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  ///--- Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location){
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// --- Calculate Tax
  static String calculateTax(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // Get Tax Rate from API or Database
    return 0.10; // Example tax rate of 10%
  }

  static double getShippingCost(String location) {
    // Get Shipping Cost based on location of user also via API
    return 5.00; // Example Shipping cosr of E5
  }
  /// --- Sum all cart values and return total amount
  // static double calculateCartTotal(CartModel cart){
  //  
  // }
}