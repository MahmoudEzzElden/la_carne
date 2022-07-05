import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:la_carne/controller/product_provider.dart';
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
    Provider.of<ProductProvider>(context,listen: false).getCartAndFavCounts();
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('You really want to Leave?'),
            actions: [
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
            ],
          ),
        ));
      },
      child: DefaultTabController(
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
        IconButton(
          onPressed: (){
            Navigator.pushNamed(context, Favourites.routeName);
          },
          icon: Badge(
            animationType: BadgeAnimationType.fade,
            badgeContent:Provider.of<ProductProvider>(context).favouritesCount==null? Text('0'):
            Text("${Provider.of<ProductProvider>(context).favouritesCount}"),
              child: Icon(Icons.favorite)),
        ),
        IconButton(
            onPressed: (){
              Navigator.pushNamed(context, Cart.routeName);
        }, icon: Badge(
            animationType: BadgeAnimationType.fade,
            badgeContent: Provider.of<ProductProvider>(context).cartCount==null? Text('0'):
            Text("${Provider.of<ProductProvider>(context).cartCount}"),
            child: Icon(Icons.shopping_cart))),
        IconButton(onPressed: ()async{
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('You really want to Log out?'),
              actions: [
                TextButton(
                    onPressed: () async {
                      final ref= await SharedPreferences.getInstance();
                      ref.setBool('goHome', false);
                      SystemNavigator.pop();
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No')),
              ],
            ),
          );

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
          // floatingActionButton: Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     FloatingActionButton(
          //       heroTag: 'fav',
          //       onPressed: (){
          //      Navigator.pushNamed(context, Favourites.routeName);
          //     },child: Icon(Icons.favorite),backgroundColor: Color(0xFFEF4444),),
          //     SizedBox(height: 5,),
          //     FloatingActionButton(
          //       heroTag: 'cart',
          //       onPressed: (){
          //       Navigator.pushNamed(context, Cart.routeName);
          //     },child: Icon(Icons.shopping_cart),backgroundColor: Color(0xFFEF4444),)
          //   ],
          // ),
        ),
      ),
    );
  }

}
