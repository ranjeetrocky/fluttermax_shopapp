class Product {
  final String id, title, description;
  final double price;
  final String imgUrl;
  bool isFavourite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.isFavourite,
  });
}
