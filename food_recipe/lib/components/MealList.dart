import 'package:flutter/material.dart';
import 'package:food_recipe/components/RecipePage.dart';

import '../apiCall.dart';

class MealList extends StatelessWidget {
  final mealType;
  const MealList({Key? key, this.mealType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future data = getDishes(mealType);
    return Scaffold(
      appBar: AppBar(
        title: Text(mealType,
            style: TextStyle(color: Theme.of(context).primaryColor)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
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
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data['hits'].length,
                itemBuilder: (BuildContext context, int index) {
                  return (ListTile(
                    style: ListTileStyle.list,
                    leading: Image.network(
                      snapshot.data['hits'][index]['recipe']['image'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      snapshot.data['hits'][index]['recipe']['label'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                      snapshot.data['hits'][index]['recipe']['source'],
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
                            name: snapshot.data['hits'][index]['recipe']
                                ['label'],
                            ingredients: snapshot.data['hits'][index]['recipe']
                                ['ingredients'],
                            image: snapshot.data['hits'][index]['recipe']
                                ['image'],
                            source: snapshot.data['hits'][index]['recipe']
                                ['source'],
                            cuisine: snapshot.data['hits'][index]['recipe']
                                ['cuisineType'],
                            nutrition: snapshot.data['hits'][index]['recipe']
                                ['totalNutrients'],
                            mealType: snapshot.data['hits'][index]['recipe']
                                ['mealType'],
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
