import 'package:flex_box/screen/forget_password_screen.dart';
import 'package:flex_box/screen/home_screen.dart';
import 'package:flex_box/screen/signup_screen.dart';
import 'package:flex_box/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = false;
  bool isAuthenticated = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
    // getIsAuthenticated();
  }

  signin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // setIsAuthenticated();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
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
                    key: _formSignInKey,
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          // Expanded(child: )
                          const Text(
                            "Wellcome Back!",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 102, 183, 248)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
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
                            controller: passwordController,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: rememberPassword,
                                        onChanged: (value) {
                                          setState(() {
                                            rememberPassword = value!;
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ]),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const ForgetPasswordScreen();
                                    }));
                                  },
                                  child: const Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 33, 152, 243)),
                                  ),
                                )
                              ]),
                          SizedBox(
                            // height: 10,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formSignInKey.currentState!.validate() &&
                                    rememberPassword) {
                                  signin(emailController.text,
                                      passwordController.text);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //         content: Text("Sign in success")));
                                } else if (!rememberPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please remember password")));
                                }
                              },
                              child: const Text('Sign In'),
                            ),
                          ),
                          Row(
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const SignupScreen();
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
                              Icon(Bootstrap.google),

                              /// BoxIcons' Icon
                              Icon(BoxIcons.bxl_apple),
                              Icon(BoxIcons.bxl_facebook),
                            ],
                          )
                        ])),
              ),
            ))
      ],
    ));
  }

  // void setIsAuthenticated() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool("IsAuthenticated", true);
  // }

  // Future<dynamic> getIsAuthenticated() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool isAuthenticated = prefs.getBool("IsAuthenticated") ?? false;
  //   print(isAuthenticated);
  //   if (isAuthenticated) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  //   }
  // }
}
