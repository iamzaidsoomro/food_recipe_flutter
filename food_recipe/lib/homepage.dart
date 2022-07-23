import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/components/Categories.dart';
import 'package:food_recipe/components/Drawer.dart';
import 'package:food_recipe/components/dishes.dart';
import 'package:food_recipe/components/searchbar.dart';
import 'package:food_recipe/components/userbar.dart';
import 'package:food_recipe/components/italianCuisine.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        elevation: 0,
        title: Text('Cookpad',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const UserBar(),
          const SearchBar(),
          const SizedBox(height: 20),
          Categories(),
          const SizedBox(height: 20),
          Dishes(title: "Popular Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "Pakistani Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "Continental Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "Chinese Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "Italian Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "Indian Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "American Dishes"),
          const SizedBox(height: 20),
          Dishes(title: "Russian Dishes"),
        ]),
      ),
    );
  }
}
