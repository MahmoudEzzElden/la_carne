
import 'package:flutter/cupertino.dart';
import 'package:la_carne/services/firebase_handler.dart';


class ProductProvider with ChangeNotifier{
   double? totalPrice;
   int? favouritesCount;
   int? cartCount;
   List? counts;
   Future getTotalPrice()async{
     totalPrice=await FirebaseHandler.getTotalPrice();
     notifyListeners();
   }
   Future getCartAndFavCounts()async{
     counts= await  FirebaseHandler.getCounts();
     favouritesCount=counts![0];
     cartCount=counts![1];

     notifyListeners();
   }



}