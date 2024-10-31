import 'package:flutter_ecommerc/src/data/model/post.dart';

abstract class PostEvent {}

class GetPostEvent extends PostEvent {}

class AddPostEvent extends PostEvent {
  final Post post;
 
  AddPostEvent({required this.post});
}

class DeletePostEvent extends PostEvent {
  final int id;
  DeletePostEvent(this.id);
}

class UpdatePostEvent extends PostEvent {
  final int id;
  final Post post;
  UpdatePostEvent(this.id, this.post);
}
