import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_carne/services/constant.dart';
import 'package:la_carne/services/firebase_handler.dart';
import 'package:la_carne/view/widgets/cart_product_card.dart';

class Cart extends StatelessWidget {
  static const String routeName = 'Cart';

  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double resu = 0;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
          title: Text('My Cart'),
          elevation: 5,
          backgroundColor: Color(0xFFEF4444)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Text(
              'Items',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseHandler.getCart(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(

                        child: ListView.builder(
                            itemCount: snapshot.requireData.size,
                            itemBuilder: (context, index) {
                              // if (snapshot.requireData.size != 0) {
                              //   (resu += snapshot.requireData.docs[index]
                              //           [productPrice] *
                              //       snapshot.requireData.docs[index]
                              //           [quantityInCart]);
                              // }

                              return snapshot.requireData.size == 0
                                  ? Center(
                                      child: Text(
                                        'There is no items in the cart',
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.white),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {},
                                      child: CartProduct(
                                        imageUrl: snapshot
                                            .requireData.docs[index][imageUrl],
                                        productPrices: snapshot.requireData
                                            .docs[index][productPrice],
                                        productNames: snapshot.requireData
                                            .docs[index][productName],
                                        productWeights: snapshot.requireData
                                            .docs[index][productWeight],
                                        quantInCart: snapshot.requireData
                                            .docs[index][quantityInCart],
                                      ),
                                    );
                            }),
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
          ),
          TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50),
                ),
                backgroundColor: MaterialStateProperty.all(Color(0xFFEF4444))),
            onPressed: () {},
            child: Text(
              "$resu",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
