import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerc/src/data/domain/post_repository.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_state.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostStateInitial()) {
   
    on<GetPostEvent>((event, emit) async {
      emit(PostStateLoading());
      try {
        final response = await postRepository.fetchPosts();
        if (response.isNotEmpty) {
          emit(PostStateSuccess(response));
        } else {
          emit(PostStateErrorState("No posts found."));
        }
      } catch (e) {
        emit(PostStateErrorState("Failed to fetch posts. ${e.toString()}"));
      }
    });

    
    on<AddPostEvent>((event, emit) async {
      emit(AddPostStateLoading());
      try {
        final response = await postRepository.createPost(event.post);
        if (response) {
          emit(AddPostStateSuccess());
        } else {
          emit(AddPostStateErrorState("Failed to add post."));
        }
      } catch (e) {
        emit(AddPostStateErrorState("Failed to add post. ${e.toString()}"));
      }
    });

   
    on<DeletePostEvent>((event, emit) async {
      emit(DeletePostStateLoading());
      try {
        await postRepository.deletePost(event.id);
        emit(DeletePostStateSuccess());
      } catch (e) {
        emit(DeletePostStateErrorState("Failed to delete post. ${e.toString()}"));
      }
    });

    
    on<UpdatePostEvent>((event, emit) async {
      emit(UpdatePostStateLoading());
      try {
        await postRepository.updatePost(event.id,event.post);
        emit(UpdatePostStateSuccess());
      } catch (e) {
        emit(UpdatePostStateErrorState("Failed to update post. ${e.toString()}"));
      }
    });
  }
}
