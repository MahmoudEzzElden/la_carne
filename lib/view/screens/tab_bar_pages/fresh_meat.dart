import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:la_carne/model/product_model.dart';
import 'package:la_carne/services/constant.dart';
import 'package:la_carne/services/firebase_handler.dart';
import 'package:la_carne/view/widgets/product_card.dart';


class FreshMeat extends StatefulWidget {
  static const routeName = 'FreshMeat';


  const FreshMeat({Key? key}) : super(key: key);

  @override
  State<FreshMeat> createState() => _FreshMeatState();
}

class _FreshMeatState extends State<FreshMeat> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseHandler.getProducts(freshCategory),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  padding: EdgeInsets.all(10),
                  child:GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 250
                    ),
                    itemCount: snapshot.requireData.size,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          int quant=snapshot.requireData.docs[index][quantityInCart];
                          FirebaseHandler.quantityInCartUpdate(
                              snapshot.requireData.docs[index][productName],
                              quant+1
                          )
                          ;
                          FirebaseHandler.addAndRemoveCart(snapshot.requireData.docs[index][productName], true);
                        },
                        child: ProductCard(
                          quantInCart: snapshot.requireData.docs[index][quantityInCart],
                          imageUrl: snapshot.requireData.docs[index][imageUrl],
                          isItFav: snapshot.requireData.docs[index][inFav],
                          productNames: snapshot.requireData.docs[index]
                              [productName],
                          productWeights: snapshot.requireData.docs[index]
                              [productWeight],
                          productPrices: snapshot.requireData.docs[index]
                              [productPrice],
                        ),
                      );
                    },
                  ),
                )
              : snapshot.hasError
                  ? Center(
                      child: Text(snapshot.error.toString()),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
        },
      ),
    );
  }
}
