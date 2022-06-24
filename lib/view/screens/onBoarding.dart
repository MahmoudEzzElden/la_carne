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
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            Provider.of<OnBoardingProvider>(context, listen: false)
                .changeIndex(index);
          },
          controller: onBoardingController,
          children: const [
            OnBoardingPages(
              imageUrl: 'assets/pageone.png',
              description:
                  'La Carne is one of the most successful, growing and most liked e-commerce application in the recent time, it is designed to make buying meat products easier for the customers.',
            ),
            OnBoardingPages(
              imageUrl: 'assets/pagetwoo.png',
              description:
                  'You can select from various types of meat products like fresh meat ,frozen meat and cold cuts just made fresh and tasty for you.',
            ),
            OnBoardingPages(
              imageUrl: 'assets/info1.jpg',
              description:
                  'To add a product into the cart ,you need to click on the product and it will increase the amount',
            ),
            OnBoardingPages(
              imageUrl: 'assets/info2.jpg',
              description:
                  'To see the details of the product you need to long press on the product and it will show you another view ,so you can see the product more clearly',
            ),
            OnBoardingPages(
              imageUrl: 'assets/pagethree.png',
              description:
                  'Once you select what you need, it will be delivered as fast as possible to your home with our fast delivery.',
            ),
          ],
        ),
      ),
      bottomSheet: Provider.of<OnBoardingProvider>(context).index == 4
          ? Container(
              height: 80,
              color: const Color(0xFFD69D9D),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        final ref = await SharedPreferences.getInstance();
                        ref.setBool('goHome', true);
                        Navigator.pushNamed(context, HomePage.routeName);
                      },
                      child: const Text(
                        'Get Started',
                        style:
                            const TextStyle(fontSize: 20, color: Color(0xFFEF4444)),
                      )),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFD69D9D),
              // padding: EdgeInsets.symmetric(horizontal: 100),
              height: 80,
              child: Row(
                children: [
                  // SizedBox(width:20 ,),
                  TextButton(
                    child: const Text(
                      'Previous',
                      style: const TextStyle(fontSize: 20, color: Color(0xFFEF4444)),
                    ),
                    onPressed: () {
                      onBoardingController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCirc);
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SmoothPageIndicator(
                      effect: const JumpingDotEffect(dotColor: Color(0xFFEF4444)),
                      controller: onBoardingController,
                      count: 5),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20, color: const Color(0xFFEF4444)),
                    ),
                    onPressed: () {
                      onBoardingController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCirc);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
