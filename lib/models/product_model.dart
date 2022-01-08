class ProductModel {
  String productName;
  String productImage;
  int productPrice;
  String productId;
  List<dynamic> productUnit;
  ProductModel({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productUnit,
  });
}
