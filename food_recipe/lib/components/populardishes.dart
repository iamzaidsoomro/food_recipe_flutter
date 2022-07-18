import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PopularDishes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future data = getPopularDishes("popular");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Popular Dishes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        FutureBuilder(
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          snapshot.data['hits'][index]['recipe']
                                              ['label'],
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
                                                  179, 14, 14, 14)),
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
                    ));
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  getPopularDishes(searchKey) async {
    var url = Uri.https('api.edamam.com', '/search', {
      "q": searchKey,
      "app_id": "0c4636ef",
      "app_key": "e5242b0d9492e44afd67a0dff4dd4c56",
    });
    var response =
        await http.get(url).then((value) => convert.jsonDecode(value.body));
    print(response);
    return response;
  }
}
