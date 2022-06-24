import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:la_carne/view/screens/tab_bar_pages/cold_cuts.dart';
import 'package:provider/provider.dart';

import '../../controller/product_provider.dart';
import '../../services/constant.dart';
import '../../services/firebase_handler.dart';

class CartProduct extends StatelessWidget {
  final String? imageUrl;
  final int? quantInCart;
  final String? productNames;
  final String? productWeights;
  final productPrices;

  const CartProduct(
      {Key? key,
      this.imageUrl,
      this.quantInCart,
      this.productNames,
      this.productWeights,
      this.productPrices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: 'EGP');
    return Card(
      color: Colors.black12,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      elevation: 10,
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: imageUrl!,
          height: 70,
          width: 70,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Container(
            color: Colors.black,
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productNames!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              productWeights!,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(

              "${formatCurrency.format(productPrices * quantInCart)}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RawMaterialButton(
                constraints: BoxConstraints.tight(Size(20, 20)),
                shape: CircleBorder(),
                fillColor: Color(0xFFEF4444),
                onPressed: () {
                  if (quantInCart == 0) {
                    return null;
                  } else {
                    FirebaseHandler.quantityInCartUpdate(
                        productNames!, quantInCart! - 1);
                    // Provider.of<ProductProvider>(context, listen: false)
                    //     .decreasePrice(
                    //    productPrices);
                    if (quantInCart == 1) {
                      FirebaseHandler.addAndRemoveCart(productNames!, false);
                    }
                  }
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 18,
                )),
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(20, 20)),
              shape: CircleBorder(),
              fillColor: Color(0xFFEF4444),
              onPressed: () {},
              child: Text(
                quantInCart.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            RawMaterialButton(
                constraints: BoxConstraints.tight(Size(20, 20)),
                shape: CircleBorder(),
                fillColor: Color(0xFFEF4444),
                onPressed: () {
                  FirebaseHandler.quantityInCartUpdate(
                      productNames!, quantInCart! + 1);
                  // Provider.of<ProductProvider>(context, listen: false)
                  //     .increasePrice(
                  //    productPrices);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                )),
          ],
        ),
      ),
    );
  }
}
