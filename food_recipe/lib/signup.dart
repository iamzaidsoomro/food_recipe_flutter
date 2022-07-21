import 'package:flutter/material.dart';
import 'package:food_recipe/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var details = {"name": "", "email": "", "password": "", "favorites": []};
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  details["name"] = value;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value == "" ||
                                      value.length < 3) {
                                    return 'Please enter valid name';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  details["email"] = value;
                                },
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
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  details["password"] = value;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value == "" ||
                                      value.length < 6) {
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
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  elevation: MaterialStateProperty.all(3),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 50)),
                                  maximumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 50)),
                                ),
                                onPressed: () => {
                                  if (formKey.currentState!.validate())
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(MaterialBanner(
                                        content: Text(
                                          "Please wait while we create your account",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        actions: [
                                          CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ],
                                      )),
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                            email: details["email"]
                                                .toString()
                                                .trim(),
                                            password: details["password"]
                                                .toString()
                                                .trim(),
                                          )
                                          .then((value) => {
                                                FirebaseAuth
                                                    .instance.currentUser
                                                    ?.updateDisplayName(
                                                  details["name"]
                                                      .toString()
                                                      .trim(),
                                                ),
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(details["email"]
                                                        .toString()
                                                        .trim())
                                                    .set(details)
                                                    .then((value) => {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentMaterialBanner(),
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomePage(),
                                                              )),
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Text(
                                                            "Sign Up Successful",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .greenAccent),
                                                          )))
                                                        })
                                                    .catchError((error) => {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentMaterialBanner(),
                                                          if (error
                                                              .toString()
                                                              .contains(
                                                                  "email"))
                                                            {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    "Email already exists"),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ))
                                                            }
                                                          else if (error
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(
                                                                  "a network error"))
                                                            {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("Please check your Internet Connection")))
                                                            }
                                                          else
                                                            {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    "Sign Up Failed"),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ))
                                                            }
                                                        })
                                              })
                                          .catchError((error) => {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner(),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Sign Up Failed: ${error.value}",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ))
                                              })
                                          .catchError((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner(),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Sign Up Failed: ${value.value}",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ))
                                              }),
                                    }
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          onPressed: () => {},
                          child: Text('Already have an account? Sign In',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
