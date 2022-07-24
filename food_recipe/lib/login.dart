import 'package:flutter/material.dart';
import 'package:food_recipe/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe/signup.dart';
import 'package:splashscreen/splashscreen.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String _email = "", _password = "";
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 300,
                    width: 300),
                Text('Login',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value == "" ||
                                  !value.contains("@") ||
                                  !value.contains(".") ||
                                  value.length < 5) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value == "" ||
                                  value.length < 5) {
                                return 'Please enter valid password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              _password = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              if (formKey.currentState!.validate())
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          "Please wait while we sign you in"),
                                      action: SnackBarAction(
                                        label: "⏳",
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _email, password: _password)
                                      .then((value) => {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        SplashScreen(
                                                          seconds: 5,
                                                          navigateAfterSeconds:
                                                              HomePage(),
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .scaffoldBackgroundColor,
                                                          title: Text('Cookpad',
                                                              style: TextStyle(
                                                                  fontSize: 50,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                          gradientBackground:
                                                              LinearGradient(
                                                            colors: [
                                                              Color(0xff1e2757),
                                                              Color(0xff141a3a)
                                                            ],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                          ),
                                                          useLoader: false,
                                                        ))),
                                                (route) => false),
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars(),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                              'Login Successful',
                                              style: TextStyle(
                                                  color: Colors.greenAccent),
                                            ))),
                                          })
                                      .catchError((error) => {
                                            print(error),
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars(),
                                            if (error.toString().contains(
                                                "password is invalid"))
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                  'Wrong Password',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ))),
                                              }
                                            else if (error
                                                .toString()
                                                .toLowerCase()
                                                .contains("no user record"))
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                  'Account doesn\'t exist',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ))),
                                              }
                                            else if (error
                                                .toString()
                                                .toLowerCase()
                                                .contains("a network error"))
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                  'Please check your Internet Connection',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ))),
                                              }
                                            else
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                  'An unknown error occurred',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ))),
                                              }
                                          })
                                }
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              maximumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50)),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.maxFinite, 50)),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(email: _email)
                                      .then((value) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Email has been sent to $_email"),
                                          )))
                                      .onError((error, stackTrace) {
                                    print(error);
                                    return ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "An error occurred while sending email"),
                                    ));
                                  });
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                              const Text(
                                ' | ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp()));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
