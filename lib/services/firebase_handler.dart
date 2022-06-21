import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carne/model/product_model.dart';
import 'package:la_carne/services/constant.dart';

class FirebaseHandler{
static ProductModel? productModel;
static getProducts(String category){
return FirebaseFirestore.instance.collection(productsCollection).where(categoryName,isEqualTo: category).snapshots();
}



static getCart(){
 return FirebaseFirestore.instance.collection(productsCollection).where(inCart,isEqualTo: true).snapshots();
}
static getFavouriteProducts(){
  return FirebaseFirestore.instance.collection(productsCollection).where(inFav,isEqualTo: true).snapshots();
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
