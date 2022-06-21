import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_carne/controller/onboarding_provider.dart';
import 'package:la_carne/view/screens/cart.dart';
import 'package:la_carne/view/screens/favourites.dart';
import 'package:la_carne/view/screens/home_page.dart';
import 'package:la_carne/view/screens/onBoarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/product_card_provider.dart';
late final goHome;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final ref= await SharedPreferences.getInstance();
   goHome=ref.getBool('goHome');
  runApp(MultiProvider(
    child:  MyApp(


    ),
      providers: [
        ChangeNotifierProvider<OnBoardingProvider>(
            create: (context) => OnBoardingProvider()),
        ChangeNotifierProvider<CardProvider>(
            create: (context) => CardProvider()),
      ]
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routeName:(context)=>HomePage(),
        Cart.routeName:(context)=>Cart(),
        Favourites.routeName:(context)=>Favourites()
      },
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home: const Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xFFD69D9D),
        splashIconSize: 200,
        splash: Center(
          child: Container(
            child: Column(
              children: [

                CircleAvatar(
                  radius: 100,
                 backgroundColor: Color(0xFFEF4444),
                  child: Text('La Carne',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),),
                )
              ],
            ),
          ),
        ),
        nextScreen:(goHome==false || goHome==null) ?  OnBoarding():HomePage());
  }
}
