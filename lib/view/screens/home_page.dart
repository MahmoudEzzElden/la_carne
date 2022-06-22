import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:la_carne/controller/product_card_provider.dart';
import 'package:la_carne/services/constant.dart';
import 'package:la_carne/services/firebase_handler.dart';
import 'package:la_carne/view/screens/cart.dart';
import 'package:la_carne/view/screens/favourites.dart';
import 'package:la_carne/view/screens/tab_bar_pages/cold_cuts.dart';
import 'package:la_carne/view/screens/tab_bar_pages/fresh_meat.dart';
import 'package:la_carne/view/screens/tab_bar_pages/frozen_meat.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String routeName='HomePage';
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {




  @override
  Widget build(BuildContext context) {

   // Provider.of<CardProvider>(context,listen: false).getTheFavCount();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
appBar: AppBar(
  elevation: 5,
  backgroundColor: Color(0xFFEF4444),
  automaticallyImplyLeading: false,
  bottom: TabBar(tabs: [
      Tab(text: 'Fresh Meat'),
      Tab(text: 'Frozen Meat'),
      Tab(text: 'Cold Cuts'),
  ],

  ),
  actions: [
      // IconButton(
      //   onPressed: (){
      //
      //   },
      //   icon: Badge(
      //     animationType: BadgeAnimationType.fade,
      //     badgeContent: Text("${Provider.of<CardProvider>(context,listen: false).favCount}"),
      //       child: Icon(Icons.favorite)),
      // ),
      IconButton(
          onPressed: (){

      }, icon: Icon(Icons.shopping_cart)),
      IconButton(onPressed: ()async{
        final ref=await SharedPreferences.getInstance();
        ref.setBool('goHome', false);
        SystemNavigator.pop();
      }, icon: Icon(Icons.logout))
  ],
  title: Text('La Carne'),
),
        body: TabBarView(
          children: [
            FreshMeat(),
            FrozenMeat(),
            ColdCuts(),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'fav',
              onPressed: (){
             Navigator.pushNamed(context, Favourites.routeName);
            },child: Icon(Icons.favorite),backgroundColor: Color(0xFFEF4444),),
            SizedBox(height: 5,),
            FloatingActionButton(
              heroTag: 'cart',
              onPressed: (){
              Navigator.pushNamed(context, Cart.routeName);
            },child: Icon(Icons.shopping_cart),backgroundColor: Color(0xFFEF4444),)
          ],
        ),
      ),
    );
  }

}
