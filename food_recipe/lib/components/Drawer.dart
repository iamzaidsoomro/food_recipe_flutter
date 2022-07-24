import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe/Favorites.dart';
import 'package:food_recipe/loginsignup.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var details = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.zero,
              accountName: Text("${details?.displayName}"),
              accountEmail: Text("${details?.email}"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/userIcon.png'),
              )),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Favorites()),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return LoginSignup();
                  }, transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                  (Route route) => false);
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
