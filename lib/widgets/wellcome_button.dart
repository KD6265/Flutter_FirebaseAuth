import 'package:flutter/material.dart';

class WellcomeButton extends StatelessWidget {
const WellcomeButton({ super.key , required this.buttonText,required this.onTap, this.color = Colors.blue, });
  final String buttonText ;
  final Widget onTap;
  final Color color;
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) =>onTap));
        },
      child: Container(
        // color: color,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
         color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
          )
        ),
        child: Text(buttonText,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ),
    );
  }
}