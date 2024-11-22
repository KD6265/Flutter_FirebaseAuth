import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_box/screen/home_screen.dart';
import 'package:flex_box/screen/signIn_screen.dart';
import 'package:flex_box/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

// import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formSignUpKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = '';
  String _password = '';

  signup() async {
    if (_formSignUpKey.currentState!.validate()) {
      // If the form is valid, display a snackbar
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
      try {
        if (_email.isNotEmpty && _password.isNotEmpty) {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          print(userCredential.user!.uid);
          if (userCredential.user != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        }
      } catch (e) {}
    }
  }

  // _handleGoogleSignIn() async{
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } on Exception catch (e) {
  //     // TODO
  //     print('exception->$e');
  //   }
  //
  // }

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
        Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                    key: _formSignUpKey,
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          // Expanded(child: )
                          const Text(
                            "Sign Up!",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 102, 183, 248)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  // borderRadius = const BorderRadius.all(Radius.circular(4.0)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  gapPadding: 4.0),
                              labelText: 'Email',
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty
                                    ? 'Please enter email'
                                    : null),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  // borderRadius = const BorderRadius.all(Radius.circular(4.0)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  gapPadding: 4.0),
                              labelText: "password",
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter password'
                                : null,
                          ),

                          SizedBox(
                            // height: 10,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // _isButtonDisabled = true;
                                  _email = _emailController.text;
                                  _password = _passwordController.text;
                                });
                                signup();
                              },
                              child: const Text('Sign In'),
                            ),
                          ),
                          Row(
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const SignInScreen();
                                  }));
                                },
                                child: const Text('Sign Up'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color.fromARGB(255, 209, 189, 189),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Sign Up with"),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color.fromARGB(255, 244, 167, 167),
                              ),
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(AntDesign.gitlab_fill),

                              /// Bootstrap's Icon
                              // const Icon(Bootstrap.google),
                              // InkWell(
                              //   // onTap: _handleGoogleSignIn, // Call the sign-in method
                              //   child: const  Icon(Bootstrap.google),
                              // ),

                              /// BoxIcons' Icon
                              Icon(BoxIcons.bxl_apple),
                              // const Icon(BoxIcons.bxl_facebook),
                            ],
                          )
                        ])),
              ),
            ))
      ],
    ));
  }
}
