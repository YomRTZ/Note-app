import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_ecommerc/src/constant/utils/url.dart';
import 'package:flutter_ecommerc/src/data/model/post.dart';
import 'package:flutter_ecommerc/src/constant/token/token.dart';

class PostProvider {
  Future<List<Post>> fetchData() async {
    String? token = await Token.getToken();
    if (token == null) {
      throw Exception("Token is missing");
    }

    final response = await http.get(
      Uri.parse('${APPURL.BASEURL}/post'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> data = responseData['data'];
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  // Add Post
  Future<bool> addPost(Post post) async {
    print("post data:${post.body}");
    try {
      String? token = await Token.getToken();
      if (token == null) {
        throw Exception("Token is missing");
      }
      print('token for a specific user add the post:$token');
      final response = await http.post(
        Uri.parse('${APPURL.BASEURL}/create_post'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(post.toJson()),
      );
      print("data:${response.body}");
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to create post");
      }
    } catch (error) {
      rethrow;
    }
  }

  // Delete Post
  Future<bool> deletePost(int id) async {
    try {
      String? token = await Token.getToken();
      if (token == null) {
        throw Exception("Token is missing");
      }

      final response = await http.delete(
        Uri.parse('${APPURL.BASEURL}/post/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
         print("data:${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } 
      catch (e, stacktrace) {
      print("Exception: $e");
      print("Stack trace: $stacktrace");
      throw Exception(e.toString());
    }
  }

  // Update Post
  Future<Post> updatePost(int id, Post post) async {
    try {
      print("id:$id");
      String? token = await Token.getToken();
      if (token == null) {
        throw Exception("Token is missing");
      }

      final response = await http.put(
        Uri.parse('${APPURL.BASEURL}/update_news/$id'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(post.toJson()),
      );
      print("response:${response.body}");
        print("response:${response.statusCode}");
      print('${APPURL.BASEURL}/update_news/$id}');
      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        print("update error");
        throw Exception("Failed to update post");
      }
    } catch (e, stacktrace) {
      print("Exception: $e");
      print("Stack trace: $stacktrace");
      throw Exception(e.toString());
    }
  }
}
// how to handle this area which is update the post based on reaction and views
// for reaction 
// for view 