import 'package:flutter/material.dart';
class OnBoardingPages extends StatelessWidget {
  final String? imageUrl;
  final String? description;
  const OnBoardingPages({Key? key, this.imageUrl, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Color(0xFFD69D9D),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 30,),
          Image.asset(imageUrl!,fit: BoxFit.cover,width: double.infinity,),
          SizedBox(height: 50,),
          Text(description!,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

