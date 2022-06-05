import 'package:flutter/material.dart';
import 'package:food_recipe/login.dart';
import 'package:food_recipe/signup.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcomebg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white.withOpacity(1),
                Colors.white.withOpacity(1),
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.8),
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.05),
                Colors.black.withOpacity(0.025),
                Colors.black.withOpacity(0.01),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Find Delicious Recipes on Cookpad",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(children: [
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            )
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            maximumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50)),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: OutlinedButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              )
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                maximumSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 50)),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 50)),
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
