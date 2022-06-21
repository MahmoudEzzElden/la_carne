import 'package:flutter/cupertino.dart';

class OnBoardingProvider with ChangeNotifier{
  int? index;
  changeIndex(int indexx){
    index=indexx;
    notifyListeners();
  }


}