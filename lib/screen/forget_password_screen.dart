import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_box/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formForgetPasswordKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  String? email;

  passwordrest() async {
    if (_formForgetPasswordKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
        emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent! Check your inbox.")),
      );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No user found for that email")));
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Your email address appears to be malformed.")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("An error occurred. Please try again.$e")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(
            height: 10,
          ),
        ),
        Flexible(
            flex: 8,
            child: Container(
              // color: Colors.red,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 7, 7, 7),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
              // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "Password Reset!\n",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                              "Password reset link sent to your email address",
                          style: TextStyle(
                            fontSize: 20,
                          ))
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formForgetPasswordKey,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelStyle:TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email,color: Color.fromARGB(255, 248, 237, 237),),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .blue), // Change this color to your desired border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .green), // Change this color for the focused state
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .red), // Change this color for the error state
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        // onChanged: (value) {
                        //   setState(() {
                        //     email = value;
                        //   });
                        //   // passwordrest();
                        // }
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    // height: 30,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            email = emailController.text;
                          });
                          passwordrest();
                        },
                        child: const Text("Reset Password")),
                  )
                ],
              )),
            )),
      ],
    ));
  }
}

// Flexible(
//             flex: 8,
//             child: Container(
//               // color: Colors.red,
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//               child:  Center(
//                 child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     children: [
//                      TextSpan(
//                       text: "Wellcome Back!\n",
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.w600
//                       )
//                      ),
//                      TextSpan(text: " is a widget that allows you to create a flexible space in your layout",
//                         style: TextStyle(
//                           fontSize: 20,
//                         )
//                       )
//                     ]
//                   ),
//                   )
//                 ),
//             )
//           ),
