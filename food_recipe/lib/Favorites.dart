import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:food_recipe/components/RecipePage.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      return value.data()?['favorites'];
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data.length == 0) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage('assets/noFavorites.png'),
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1),
                    Text("No favorites yet",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return (ListTile(
                    style: ListTileStyle.list,
                    leading: Image.network(
                      snapshot.data[index]['image'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      snapshot.data[index]['label'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                      snapshot.data[index]['source'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(
                            name: snapshot.data[index]['label'],
                            ingredients: snapshot.data[index]['ingredients'],
                            image: snapshot.data[index]['image'],
                            source: snapshot.data[index]['source'],
                            cuisine: snapshot.data[index]['cuisine'],
                            nutrition: snapshot.data[index]['nutrition'],
                            mealType: snapshot.data[index]['mealType'],
                          ),
                        ),
                      );
                    },
                  ));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
