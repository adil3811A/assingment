class ProductModel{
  final double id;
  final String title;
  final String discription;
  final String category;
  final double price;
  final List<dynamic> images;
  final String thumbnail;

  ProductModel( {required this.id, required this.title, required this.discription, required this.category, required this.price, required this.images, required this.thumbnail});

}