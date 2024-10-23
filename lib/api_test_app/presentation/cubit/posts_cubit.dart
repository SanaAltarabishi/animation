import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:reverse_string/api_test_app/data/posts_model.dart';
import 'package:reverse_string/api_test_app/data/posts_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository postsRepository;
  PostsCubit(this.postsRepository) : super(PostsInitial());

  Future<void> loadPosts() async {
    emit(const PostsLoading());
    try {
      final posts = await postsRepository.getPosts();
      emit(PostsLoaded(posts));
    } on Exception catch (e) {
      var string = e.toString();
      emit(const PostsError());
    }
  }
}
