import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carne/services/constant.dart';

class FirebaseHandler {

  static getProducts(String category) {
    return FirebaseFirestore.instance.collection(productsCollection).where(
        categoryName, isEqualTo: category).snapshots();
  }



  static getCart() {
    return FirebaseFirestore.instance.collection(productsCollection).where(
        inCart, isEqualTo: true).snapshots();
  }

  static getFavouriteProducts() {
    return FirebaseFirestore.instance.collection(productsCollection).where(
        inFav, isEqualTo: true).snapshots();
  }
static Future getTotalPrice()async{
    double num=0;
    var result=await FirebaseFirestore.instance.collection(productsCollection).where(inCart,isEqualTo: true).get();
    result.docs.forEach((element) {
     num+= (element.data()[productPrice]*element.data()[quantityInCart]);
    });
    return num;

}

  static Future getCounts() async {
    int favCount=0;
    int cartCount=0;
    var favResult= await FirebaseFirestore.instance
        .collection(productsCollection)
        .where(inFav, isEqualTo: true).get();
    var cartResult=await FirebaseFirestore.instance
        .collection(productsCollection)
        .where(inCart, isEqualTo: true).get();
   favCount= favResult.docs.length;
   cartCount = cartResult.docs.length;

    return
      [favCount,cartCount];
  }


  static favouriteUpdate(String documentId,bool result){
    FirebaseFirestore.instance.collection(productsCollection).doc(documentId).update({
      inFav:result,
    });
  }

  static quantityInCartUpdate(String productId,int result){
    FirebaseFirestore.instance.collection(productsCollection).doc(productId).update({
      quantityInCart:result,
    });

  }


  static addAndRemoveCart(String docId,bool result){
    FirebaseFirestore.instance.collection(productsCollection).doc(docId).update({
      inCart:result
    });
  }



}


// static addToDatabase(String name,String weight,double price){
//   FirebaseFirestore.instance.collection(productsCollection).doc(name).set({
//     productName:name,
//     productWeight:weight,
//     productPrice:price,
//     quantityInCart:0,
//     inFav:false,
//     inCart:false,
//     categoryName:'Cold Cuts',
//   });
// }