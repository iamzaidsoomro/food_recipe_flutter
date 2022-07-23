import 'package:flutter/material.dart';
import 'package:food_recipe/searchResults.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      child: TextField(
        onSubmitted: (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchResults(
                searchKey: value,
              ),
            ),
          );
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
