import 'package:flutter/cupertino.dart';

class CardProvider with ChangeNotifier{
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