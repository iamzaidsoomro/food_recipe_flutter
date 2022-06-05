import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    height: 350,
                    width: 350),
                Text('Login',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        TextField(
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
                        TextField(
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
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            )
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
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
