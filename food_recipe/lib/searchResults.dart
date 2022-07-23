import "package:flutter/material.dart";
import "package:food_recipe/components/RecipePage.dart";
import "package:food_recipe/apiCall.dart";
import "package:food_recipe/components/searchbar.dart";

class SearchResults extends StatefulWidget {
  final String searchKey;
  const SearchResults({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    var data = getDishes(widget.searchKey);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
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
            iconColor: Colors.grey,
            focusColor: Theme.of(context).primaryColor,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
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
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data["count"] < 1) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text("No Results for ${widget.searchKey}",
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data['hits'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      (ListTile(
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
                          style: const TextStyle(
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
                                ingredients: snapshot.data['hits'][index]
                                    ['recipe']['ingredients'],
                                image: snapshot.data['hits'][index]['recipe']
                                    ['image'],
                                source: snapshot.data['hits'][index]['recipe']
                                    ['source'],
                                cuisine: snapshot.data['hits'][index]['recipe']
                                    ['cuisineType'],
                                nutrition: snapshot.data['hits'][index]
                                    ['recipe']['totalNutrients'],
                                mealType: snapshot.data['hits'][index]['recipe']
                                    ['mealType'],
                              ),
                            ),
                          );
                        },
                      )),
                      Divider(
                        color: Color.fromARGB(166, 158, 158, 158),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
