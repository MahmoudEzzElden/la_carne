import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carne/services/constant.dart';

class ProductModel{
  String? name;
  String? weight;
  String? url;
  int? quantity;
  var price;
  bool? inFavourites;
  bool? inCarts;

  ProductModel(
      {this.name,
        this.weight,
        this.url,
        this.quantity,
        this.price,
        this.inFavourites,
        this.inCarts});

  factory ProductModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return ProductModel(
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

