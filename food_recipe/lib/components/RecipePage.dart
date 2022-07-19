import 'dart:ui';
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';

class RecipePage extends StatelessWidget {
  final name, ingredients, source, image, cuisine, nutrition, mealType;
  const RecipePage(
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
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
                          name,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text("by $source",
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
                        mealType[0],
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
                        cuisine[0],
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
                        nutrition['ENERC_KCAL']['quantity'].round().toString() +
                            ' ' +
                            nutrition['ENERC_KCAL']['unit'].toString(),
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
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.check,
                        color: Theme.of(context).primaryColor),
                    title: Text(ingredients[index]['text']),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.favorite_border),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
