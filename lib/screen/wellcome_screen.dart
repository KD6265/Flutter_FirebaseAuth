import 'package:flex_box/screen/signIn_screen.dart';
import 'package:flex_box/screen/signup_screen.dart';
import 'package:flex_box/widgets/custom_scaffold.dart';
import 'package:flex_box/widgets/wellcome_button.dart';
import 'package:flutter/material.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({super.key});
   
  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(child: 
      Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              // color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),  
              child:  Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [ 
                     TextSpan(
                      text: "Wellcome Back!\n",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600
                      )
                     ),
                     TextSpan(text: " is a widget that allows you to create a flexible space in your layout",
                        style: TextStyle(
                          fontSize: 20,
                        )
                      )
                    ]
                  ),
                  )
                ),
            )
          ),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
              children: [
                Expanded(child: WellcomeButton(buttonText:"Sign in",onTap: SignInScreen(),color: Color.fromARGB(255, 239, 206, 206),)),
                Expanded(child: WellcomeButton(buttonText: 'Sign up',onTap:SignupScreen(),color:Colors.white,)),
              ],
                        ),
            )
          )
        ],
      )
    );
  }
}