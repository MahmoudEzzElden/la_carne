import 'package:la_carne/services/constant.dart';

class ProductModel{
List<Product> products=[];
ProductModel.fromJson(documents) {
  products = <Product>[];
 documents.forEach((v) {
    products.add(Product.fromJson(v));
  });
}
}

class Product{
  String? name;
  String? weight;
  String? url;
  int? quantity;
  var price;
  bool? inFavourites;
  bool? inCarts;

  Product(
      {this.name,
        this.weight,
        this.url,
        this.quantity,
        this.price,
        this.inFavourites,
        this.inCarts});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json[productName],
        weight: json[productWeight],
        url: json[imageUrl],
        quantity: json[quantityInCart],
        price: json[productPrice],
        inFavourites: json[inFav],
        inCarts: json[inCart]


    );
  }


}

