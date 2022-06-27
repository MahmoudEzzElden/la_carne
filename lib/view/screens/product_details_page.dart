import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
  
class ProductDetails extends StatelessWidget {
  static const routeName='ProductDetails';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List args=ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFFEF4444),
        title: Text(args[1]),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(

              tag: args[1],
              child: CachedNetworkImage(
                imageUrl: args[0],
              ),
            ),
            SizedBox(height: 40,),
            Text('Product Weight: ${args[2]}',style: TextStyle(fontSize: 24),),
            SizedBox(height: 40,),
            Text('Product Price: ${args[3]}/EGP',style: TextStyle(fontSize: 24))
          ],
        ),
      ),
    );
  }
}
