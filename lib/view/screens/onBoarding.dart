
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_carne/controller/onboarding_provider.dart';
import 'package:la_carne/view/screens/home_page.dart';
import 'package:la_carne/view/widgets/page_view_pages.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final onBoardingController = PageController();

  @override
  void dispose() {
    onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index){
              Provider.of<OnBoardingProvider>(context,listen: false).changeIndex(index);
          },
          controller: onBoardingController,
          children: [
            OnBoardingPages(
              imageUrl:'assets/pageone.png' ,
              description:'La Carne is one of the most successfull, growing and most liked e-commerce application in the recent time, it is designed to make buying meat products easier for the customers.' ,
            ),
            OnBoardingPages(
              imageUrl: 'assets/pagetwoo.png',
              description: 'You can select from various types of meat prodcuts like fresh meat ,frozen meat and cold cuts just made fresh and tasty for you.',
            ),
            OnBoardingPages(
              imageUrl: 'assets/pagethree.png',
              description: 'Once you select what you need, it will be delivered as fast as possible to your home with our fast delivery.',
            ),
          ],
        ),
      ),
      bottomSheet: Provider.of<OnBoardingProvider>(context).index==2?
          Container(
            height: 80,
            color: Color(0xFFD69D9D),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()async {
                  final ref=await SharedPreferences.getInstance();
                  ref.setBool('goHome', true);
                  Navigator.pushNamed(context, HomePage.routeName);
                }, child: Text('Get Started',style: TextStyle(fontSize:20,color: Color(0xFFEF4444)),)),
              ],
            ),
          ):
      Container(
        padding: EdgeInsets.all(20),
        color: Color(0xFFD69D9D),
        // padding: EdgeInsets.symmetric(horizontal: 100),
        height: 80,
        child: Row(

          children: [
           // SizedBox(width:20 ,),
            TextButton(child: Text('Previous',style: TextStyle(fontSize: 20,color: Color(0xFFEF4444)),),onPressed: (){
              onBoardingController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeInCirc);
            },),
            SizedBox(width:50 ,),
            SmoothPageIndicator(
              effect: JumpingDotEffect(
                dotColor: Color(0xFFEF4444)
              ),
                controller: onBoardingController,
                count: 3),
            SizedBox(width:80 ,),
            TextButton(child: Text('Next',style: TextStyle(fontSize: 20,color: Color(0xFFEF4444)),),onPressed: (){
              onBoardingController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeInCirc);
            },),
          ],
        ),
      ),
    );
  }
}
