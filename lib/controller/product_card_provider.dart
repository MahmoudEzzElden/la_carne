import 'package:flutter/cupertino.dart';
import 'package:la_carne/services/firebase_handler.dart';

import '../model/product_model.dart';

class CardProvider with ChangeNotifier{
List<ProductModel> products=[];
int? favCount;
Future<List<ProductModel>> getProducts(String category) async {
  products = await FirebaseHandler.getProducts(category);
  notifyListeners();
  return products;
}
Future getTheFavCount()async{
 favCount= await FirebaseHandler.getFavCount();
 notifyListeners();
}


 int productQuantity=0;
 bool addToFav=false;

 increaseQuantity(){
   productQuantity++;
   notifyListeners();
 }
 decreaseQuantity(){
   productQuantity--;
   notifyListeners();
 }
 addToFavourites(){
   addToFav=!addToFav;
   notifyListeners();
 }




}