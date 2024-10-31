

class Post {
  final int? id;
  final String title;
  final String body;
  final List<String> tags;
  final Reactions? reactions;
  final int? views;
  final String? user;
  final int? userId;
  final String? avatar;

  Post(
      {this.id,
      required this.title,
      required this.body,
      required this.tags,
       this.reactions,
       this.views,
      this.avatar,
      this.user,
      this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        tags: List<String>.from(json['tags']),
        reactions: Reactions.fromJson(json['reactions']),
        views: json['views'],
        user: json['user'],
        avatar: json['avatar'],
        userId:json['userId']
        );
        
  }
  // to json
Map<String, dynamic> toJson() {
  return {
    'id':id,
    'title':title,
     'body':body,
     'tags':tags,
     'reactions':{
'likes':reactions?.likes,
'dislikes':reactions?.dislikes
    },
     'views':views,
     'user':user,
     'userId':userId,
     'avater':avatar
  };
}
}

class Reactions {
  final int likes;
  final int dislikes;

  Reactions({
    required this.likes,
    required this.dislikes,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) {
    return Reactions(
      likes: json['likes'],
      dislikes: json['dislikes'],
    );
  }
}
