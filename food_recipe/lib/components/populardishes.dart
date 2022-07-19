import 'package:flutter/material.dart';
import 'package:food_recipe/components/RecipePage.dart';

import '../apiCall.dart';

class PopularDishes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future data = getDishes("popular");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Popular Dishes",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor))),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: FutureBuilder(
            future: data,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container(
                  height: 208,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data['hits'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return (Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipePage(
                                          name: snapshot.data['hits'][index]
                                              ['recipe']['label'],
                                          ingredients: snapshot.data['hits']
                                              [index]['recipe']['ingredients'],
                                          source: snapshot.data['hits'][index]
                                              ['recipe']['source'],
                                          image: snapshot.data['hits'][index]
                                              ['recipe']['image'],
                                          cuisine: snapshot.data['hits'][index]
                                              ['recipe']['cuisineType'],
                                          nutrition: snapshot.data['hits']
                                                  [index]['recipe']
                                              ['totalNutrients'],
                                          mealType: snapshot.data['hits'][index]
                                              ['recipe']['mealType'],
                                        )));
                          },
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data['hits']
                                          [index]['recipe']['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 180,
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.9),
                                            Colors.black.withOpacity(0.7),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(0.3),
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.05),
                                            Colors.black.withOpacity(0.025),
                                            Colors.black.withOpacity(0.01),
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot.data['hits'][index]
                                                  ['recipe']['label'],
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "Source: " +
                                                  snapshot.data['hits'][index]
                                                      ['recipe']['source'],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w100,
                                                  color: Color.fromARGB(
                                                      179, 241, 241, 241)),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
