import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/models/gategories.dart';
import 'package:news_app/utilities/api_utilities.dart';

class GategoriesApi {
  Future<List<Gategories>> getAllGategories() async {
    List<Gategories> gategoriesList = [];
    String getegoriesApi = base_api + all_gategories_api;

    var response = await http.get(getegoriesApi);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      var data = jsonData["data"];

      for (var item in data) {
        Gategories gategories = Gategories(item['id'].toString(), item['title'].toString());
        gategoriesList.add(gategories);
        print(gategories.title);
      }
    }
    return gategoriesList;
  }
}
