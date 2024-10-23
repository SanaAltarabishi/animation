import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reverse_string/api_test_app/data/posts_model.dart';
import 'package:reverse_string/api_test_app/data/posts_repo.dart';
import 'package:reverse_string/api_test_app/data/remote_datasource.dart';
import 'posts_repo_test.mocks.dart';

@GenerateMocks([RemoteDatasource])
void main() {
  late RemoteDatasource mockRemoteDatasource;
  late PostsRepository postsRepository;
  setUp(
    () {
      mockRemoteDatasource =
          MockRemoteDatasource(); //came from network real >>mock
      postsRepository = PostsRepositoryImpl(mockRemoteDatasource);
    },
  );

  test(
    'should return a list of posts without any expetions ',
    () async {
//arrang:
      final posts = List.generate(
        5,
        (index) => PostsModel(
          userId: index,
          id: index,
          title: 'title $index',
          body: 'body $index',
        ),
      );

      when(mockRemoteDatasource.getPosts()).thenAnswer(
        (_) => Future.value(posts),
      );

//act :
      final result = await postsRepository.getPosts();
//assert :
      expect(result, posts);
    },
  );
}
