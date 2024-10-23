import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reverse_string/api_test_app/data/posts_model.dart';
import 'package:reverse_string/api_test_app/data/posts_repo.dart';
import 'package:reverse_string/api_test_app/presentation/cubit/posts_cubit.dart';

import 'posts_cubit_test.mocks.dart';

@GenerateMocks([PostsRepository])
void main() {
  late PostsCubit postsCubit;
  late PostsRepository mockPostsRepository;

  setUp(
    () {
      mockPostsRepository = MockPostsRepository();
      postsCubit = PostsCubit(mockPostsRepository);
    },
  );

  test(
    'posts cubit should emit postsLoading state,then emit postsLoaded with a list of posts when calling loadPosts method',
    () async {
//arrange:
      final posts = List.generate(
        5,
        (index) => PostsModel(
          userId: index,
          id: index,
          title: 'title $index',
          body: 'body $index',
        ),
      );

      when(mockPostsRepository.getPosts())
          .thenAnswer((_) => Future.value(posts));

//assert: we don't know because we have two states
      final expextedStates = [
        const PostsLoading(),
        PostsLoaded(posts),
      ];

      expectLater(
        postsCubit.stream,
        emitsInAnyOrder(expextedStates),
      );
//act :
      postsCubit.loadPosts();
    },
  );

  test(
    'postCubit should emmit PostsLoading then PostsError state if repo throw an Exeption',
    () {
//arrange:


      when(mockPostsRepository.getPosts()).thenAnswer((_) async =>
          throw Exception()); //remote >> repo >> cubit : exeption thow from layer to layer then handeled

//assert: we don't know because we have two states
      final expextedStates = [
        const PostsLoading(),
        const PostsError(),
      ];

      expectLater(
        postsCubit.stream,
        emitsInAnyOrder(expextedStates),
      );
//act :
      postsCubit.loadPosts();
    },
  );
}
