import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/utilities/api_utilities.dart';
import 'package:news_app/models/posts.dart';

class PostsApi {
  Future<List<Posts>> fetchPostsCategoriesById(String id) async {
    List<Posts> postList = List<Posts>();

    String whatsNewsApi = base_api + categories_api + id;
    var response = await http.get(whatsNewsApi);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Posts Post = Posts(
            id: item["id"].toString(),
            title: item["title"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            featuredImage: item["featured_image"].toString(),
            votesUp: item["votes_up"],
            votesDown: item["votes_down"],
            votersUp: (item["voters_up"] == null)
                ? List<int>()
                : jsonDecode(item["voters_up"]),
            votersDown: (item["voters_down"] == null)
                ? List<int>()
                : jsonDecode(item["voters_down"]),
            userId: item["user_id"],
            categoryId: item["gategory_id"]);
        postList.add(Post);
      }
    }
    return postList;
  }
}
