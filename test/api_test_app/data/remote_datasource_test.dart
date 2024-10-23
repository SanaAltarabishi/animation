import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reverse_string/api_test_app/core/service/network_service.dart';
import 'package:reverse_string/api_test_app/data/posts_model.dart';
import 'package:reverse_string/api_test_app/data/remote_datasource.dart';

import 'remote_datasource_test.mocks.dart';

@GenerateMocks([NetworkService])
// then we run this command in terminal :
//flutter pub run build_runner build --delete-conflicting-outputs
void main() {
  late  RemoteDatasourceImpl remoteDatasourceImpl;
  late  NetworkService mockNetworkService;
//the set up :  run before the test :
  setUp(() {
    mockNetworkService =
        MockNetworkService(); // this return real things that why we don't need to creat immidatly we use mock
    remoteDatasourceImpl =
        RemoteDatasourceImpl(networkService: mockNetworkService);
  });

  test(
    'Get posts should return posts without any exception',
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
      final postsMap = posts.map((post) => post.toMap()).toList();

      when(
        mockNetworkService.get('https://jsonplaceholder.typicode.com/posts'),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts',
            ),
            data: postsMap,
            statusCode: 200,
          ),
        ),
      );

      //act:
      final result = await remoteDatasourceImpl.getPosts();
      //assert:
      expect(result, posts);
    },
  );
  test(
    'Get posts should throw an exeption if the status code is not 200',
    () async {
      //arrang:
final expectedResult = throwsA(isA<Exception>());//we can defained our exeption here !!
      when(
        mockNetworkService.get('https://jsonplaceholder.typicode.com/posts'),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts',
            ),
            //  data: null,
            statusCode: 401,
          ),
        ),
      );

      //act:
      result()async => await remoteDatasourceImpl.getPosts();
      //assert:
      expect(result,expectedResult);
    },
  );
}
