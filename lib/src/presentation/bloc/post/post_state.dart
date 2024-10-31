import 'package:flutter_ecommerc/src/data/model/post.dart';
abstract class PostState {}

class PostStateInitial extends PostState {}

class PostStateLoading extends PostState {}

class PostStateSuccess extends PostState {
  final List<Post> data;
  PostStateSuccess(this.data);
}

class PostStateErrorState extends PostState {
  final String error;

  PostStateErrorState(this.error);
}

class AddPostStateInitial extends PostState {}

class AddPostStateLoading extends PostState {}

class AddPostStateSuccess extends PostState {}

class AddPostStateErrorState extends PostState {
  final String error;

  AddPostStateErrorState(this.error);
}

class DeletePostStateInitial extends PostState {}

class DeletePostStateLoading extends PostState {}

class DeletePostStateSuccess extends PostState {}

class DeletePostStateErrorState extends PostState {
  final String error;

  DeletePostStateErrorState(this.error);
}
class UpdatePostStateInitial extends PostState {}

class UpdatePostStateLoading extends PostState {}

class UpdatePostStateSuccess extends PostState {}

class UpdatePostStateErrorState extends PostState {
  final String error;

  UpdatePostStateErrorState(this.error);
}

