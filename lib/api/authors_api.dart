import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/models/authors.dart';
import 'package:news_app/utilities/api_utilities.dart';

class AuthorsApi {
  Future<List<Authors>> fetchAllAuthors() async {
    List<Authors> listAuthors = List<Authors>();

    String allAuthorsApi = base_api + all_authors_api;
    var response = await http.get(allAuthorsApi);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      var data =
          jsonData['data']; // بعمل استخراج للداتا عن طريق اني اديتله المفتاح

      for (var item in data) {
        Authors author = Authors(item['id'].toString(), item['name'].toString(),
            item['email'].toString(), item['avatar'].toString());
        listAuthors.add(author);
      }
    }
    return listAuthors;
  }
}
