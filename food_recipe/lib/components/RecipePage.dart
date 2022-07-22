import 'dart:ui';
import "package:flutter/material.dart";
import "package:food_recipe/addToFavourites.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class RecipePage extends StatefulWidget {
  final name, ingredients, source, image, cuisine, nutrition, mealType;

  RecipePage(
      {Key? key,
      @required this.name,
      @required this.ingredients,
      @required this.source,
      @required this.image,
      this.cuisine,
      this.nutrition,
      this.mealType})
      : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  var favIcon = Icons.favorite_border;
  var favIconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    var isFavorite = false;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      var favorites = value.data()?['favorites'];
      for (var i in favorites) {
        if (i['label'] == widget.name) {
          setState(() {
            favIcon = Icons.favorite_sharp;
            favIconColor = Colors.redAccent;
            isFavorite = true;
          });
        }
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover)),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.025),
                    Colors.white.withOpacity(0.01),
                  ],
                )),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text("by ${widget.source}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(160, 36, 36, 36))),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.lunch_dining_outlined,
                        color: Color.fromARGB(255, 161, 161, 161),
                        size: 30,
                      ),
                      Text(
                        widget.mealType[0],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 161, 161, 161)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: Color.fromARGB(255, 161, 161, 161),
                        size: 30,
                      ),
                      Text(
                        widget.cuisine[0],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 161, 161, 161)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.accessibility,
                        color: Color.fromARGB(255, 161, 161, 161),
                        size: 30,
                      ),
                      Text(
                        widget.nutrition['ENERC_KCAL']['quantity']
                                .round()
                                .toString() +
                            ' ' +
                            widget.nutrition['ENERC_KCAL']['unit'].toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 161, 161, 161),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: widget.ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.check,
                        color: Theme.of(context).primaryColor),
                    title: Text(widget.ingredients[index]['text']),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isFavorite) {
            addToFavourites(
                widget.name,
                widget.ingredients,
                widget.source,
                widget.image,
                widget.cuisine,
                widget.nutrition,
                widget.mealType);
            setState(() {
              favIcon = Icons.favorite_sharp;
              favIconColor = Colors.redAccent;
              isFavorite = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Added to favourites'),
              duration: Duration(seconds: 1),
            ));
          } else {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.email)
                .get()
                .then((value) {
              var favorites = value.data()?['favorites'];
              for (var i in favorites) {
                if (i['label'] == widget.name) {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .update({
                    'favorites': FieldValue.arrayRemove([i])
                  });
                  isFavorite = false;
                  setState(() {
                    favIcon = Icons.favorite_border;
                    favIconColor = Colors.white;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Removed from favorites"),
                  ));
                }
              }
            });
          }
        },
        child: Icon(favIcon, color: favIconColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
