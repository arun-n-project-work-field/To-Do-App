import 'package:flutter/material.dart';
import '../models/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text('User ID: ${post.userId}'),
    );
  }
}