import 'package:flutter/material.dart';
import 'package:food_recipe/components/populardishes.dart';
import 'package:food_recipe/components/searchbar.dart';
import 'package:food_recipe/components/userbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
          onPressed: () {},
        ),
        title: Text('Cookpad',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const UserBar(),
          const SearchBar(),
          const SizedBox(height: 20),
          PopularDishes(),
        ]),
      ),
    );
  }
}
