import 'package:flutter_ecommerc/src/data/provider/post_provider.dart';
import 'package:flutter_ecommerc/src/data/model/post.dart';

class PostRepository {
   PostProvider postProvider;
  PostRepository({required this.postProvider});
 
  // Fetch Posts
  Future<List<Post>> fetchPosts() async {
    return await postProvider.fetchData();
  }

  // Add Post
  Future<bool> createPost(Post post) async {
    return await postProvider.addPost(post);
  }

  // Delete Post
  Future<bool> deletePost(int id) async {
    return await postProvider.deletePost(id);
  }

  // Update Post
  Future<Post> updatePost(int id,Post post) async {
    return await postProvider.updatePost(id,post);
  }
}
