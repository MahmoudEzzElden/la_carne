import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:la_carne/controller/product_provider.dart';
import 'package:la_carne/services/constant.dart';
import 'package:la_carne/services/firebase_handler.dart';
import 'package:la_carne/view/widgets/cart_product_card.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static const String routeName = 'Cart';

  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen: false).getTotalPrice();
    final formatCurrency = new NumberFormat.currency(symbol: 'EGP');
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
                    ? snapshot.requireData.docs.isNotEmpty
                        ? Container(
                            child: ListView.builder(
                                itemCount: snapshot.requireData.size,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: CartProduct(
                                      imageUrl: snapshot.requireData.docs[index]
                                          [imageUrl],
                                      productPrices: snapshot.requireData
                                          .docs[index][productPrice],
                                      productNames: snapshot
                                          .requireData.docs[index][productName],
                                      productWeights: snapshot.requireData
                                          .docs[index][productWeight],
                                      quantInCart: snapshot.requireData
                                          .docs[index][quantityInCart],
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Text(
                            'There is no items in the cart',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ))
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
            child:  Provider.of<ProductProvider>(context).totalPrice ==null? Text('0.0'):

            Text(
              "${formatCurrency.format(Provider.of<ProductProvider>(context).totalPrice) }",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
