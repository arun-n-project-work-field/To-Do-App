import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];

  List<Post> get posts => _filteredPosts;

  PostProvider() {
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      List<dynamic> jsonPosts = json.decode(response.body);
      _posts = jsonPosts.map((postJson) => Post.fromJson(postJson)).toList();
      _filteredPosts = _posts;
      notifyListeners();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  void filterPosts(String userId) {
    if (userId.isNotEmpty) {
      _filteredPosts =
          _posts.where((post) => post.userId.toString() == userId).toList();
    } else {
      _filteredPosts = _posts;
    }
    notifyListeners();
  }
}
