import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:intl/intl.dart';
import '../../services/firebase_handler.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final int? quantInCart;
  final String? productNames;
  final String? productWeights;
  final  productPrices;
  final bool? isItFav;

  const ProductCard(
      {Key? key,
      this.imageUrl,
      this.productNames,
      this.productWeights,
      this.productPrices,
      this.isItFav,
      this.quantInCart}
      )
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(symbol: 'EGP');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl!,
              height: 70,
              width: 100,
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Marquee(
                pauseAfterRound: Duration(seconds: 1),
                velocity: 40,
                blankSpace: 8,
                text:productNames!,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                productWeights!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${formatCurrency.format(productPrices)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ///late work
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: quantInCart == 0 ?   false : true,
                  child: RawMaterialButton(
                      constraints: BoxConstraints.tight(Size(20, 20)),
                      shape: CircleBorder(),
                      fillColor: Color(0xFFEF4444),
                      onPressed: () {
                        if(quantInCart==0){
                          return null;
                        }
                        else{
                          FirebaseHandler.quantityInCartUpdate(productNames!, quantInCart!-1);
                          if(quantInCart==1){
                            FirebaseHandler.addAndRemoveCart(productNames!, false);
                          }
                        }


                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 18,
                      )),
                ),
                RawMaterialButton(
                    constraints: BoxConstraints.tight(Size(30, 30)),
                    shape: CircleBorder(),
                    fillColor: Color(0xFFEF4444),
                    onPressed: () {
                   FirebaseHandler.favouriteUpdate(productNames!, !isItFav!);
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: isItFav == false ? Colors.white : Colors.grey,
                    )),
                Visibility(
                  visible: quantInCart == 0 ? false : true,
                  child: RawMaterialButton(
                    constraints: BoxConstraints.tight(Size(20, 20)),
                    shape: CircleBorder(),
                    fillColor: Color(0xFFEF4444),
                    onPressed: () {
                    },
                    child: Text(
                      quantInCart.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
