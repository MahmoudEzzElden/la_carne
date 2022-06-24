import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/constant.dart';
import '../../services/firebase_handler.dart';
import '../widgets/product_card.dart';

class Favourites extends StatefulWidget {
  static const String routeName = 'Favourites';

  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        elevation: 5,
        backgroundColor: Color(0xFFEF4444),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseHandler.getFavouriteProducts(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.requireData.docs.isNotEmpty ?
          Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 250
              ),
              itemCount: snapshot.requireData.size,
              itemBuilder: (context, index) {
                return
                  GestureDetector(
                  onTap: () {
                    int quant=snapshot.requireData.docs[index][quantityInCart];
                    FirebaseHandler.quantityInCartUpdate(
                        snapshot.requireData.docs[index][productName],
                        quant+1
                    )
                    ;
                  },
                  child: ProductCard(
                    isItFav: snapshot.requireData.docs[index][inFav],
                    quantInCart: snapshot.requireData.docs[index][quantityInCart],
                    imageUrl: snapshot.requireData.docs[index][imageUrl],
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
          ): Center(child: Text('No Items In Favourites',style: TextStyle(fontSize: 24),),)
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
