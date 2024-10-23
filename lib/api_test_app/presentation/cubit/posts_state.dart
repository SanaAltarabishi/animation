// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'posts_cubit.dart';

@immutable
sealed class PostsState {
  const PostsState();
}

final class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {
  const PostsLoading(); // because postsLoading extends postsState , postsState also should have a const constructor
}

class PostsLoaded extends PostsState {
  final List<PostsModel> posts;
  const PostsLoaded(
    this.posts,
  );
//?! is this just of the testing or there is another benifits for this ?
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostsLoaded && listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}

class PostsError extends PostsState {
  final String? message;
  const PostsError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return
     other is PostsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
