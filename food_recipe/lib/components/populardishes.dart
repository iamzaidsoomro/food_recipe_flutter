import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PopularDishes extends StatefulWidget {
  const PopularDishes({Key? key}) : super(key: key);

  @override
  State<PopularDishes> createState() => _PopularDishesState();
}

class _PopularDishesState extends State<PopularDishes> {
  var query;
  @override
  Widget build(BuildContext context) {
    apiCall();
    Timer(const Duration(seconds: 3), () {});
    var label = query["hits"][0]["recipe"]["label"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Popular Dishes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Card(
            child: Column(
          children: [Image.network(query["hits"][0]["recipe"]["image"])],
        ))
      ]),
    );
  }

  apiCall() async {
    var url = Uri.https('api.edamam.com', '/search', {
      'q': 'popular dishes',
      'app_id': '0c4636ef',
      'app_key': 'e5242b0d9492e44afd67a0dff4dd4c56',
    });
    var response = await http.get(url).then((value) {
      print(value.body);
      query = convert.jsonDecode(value.body);
    });
    return query;
  }
}
