import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

getDishes(searchKey) async {
  var url = Uri.https('api.edamam.com', '/search', {
    "q": searchKey,
    "app_id": "0c4636ef",
    "app_key": "e5242b0d9492e44afd67a0dff4dd4c56",
  });
  var response =
      await http.get(url).then((value) => convert.jsonDecode(value.body));
  return response;
}
