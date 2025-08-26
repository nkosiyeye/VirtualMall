class CartItemModel{
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  String VendorId;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    required this.VendorId,
    this.selectedVariation
});

  String get totalAmount => (price * quantity).toStringAsFixed(1);

  /// Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0, VendorId: '');

  /// Convert a CartItem to a Json Map
  Map<String, dynamic> toJson(){
    return{
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'VendorId': VendorId,
      'selectedVariation': selectedVariation
    };
  }

  /// Create a CartItem from a Json Map
  factory CartItemModel.fromJson(Map<String, dynamic> json){
    return CartItemModel(
        productId: json['productId'],
        title: json['title'],
        price: json['price']?.toDouble(),
        image: json['image'],
        quantity:json['quantity'],
        variationId: json['variationId'],
        brandName: json['brandName'],
        VendorId: json['VendorId'],
        selectedVariation: json['selectedVariation'] != null ? Map<String, String>.from(json['selectedVariation']) : null,
    );
  }
}