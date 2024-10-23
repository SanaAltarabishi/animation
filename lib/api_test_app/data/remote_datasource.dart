// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:reverse_string/api_test_app/core/service/network_service.dart';
import 'package:reverse_string/api_test_app/data/posts_model.dart';

abstract class RemoteDatasource {
  Future<List<PostsModel>> getPosts();
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final NetworkService networkService;
  RemoteDatasourceImpl({
    required this.networkService,
  });

  @override
  Future<List<PostsModel>> getPosts() async {
    final response =
        await networkService.get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode != 200) throw Exception();
    final result = response.data as List;
    final posts = result.map((postMap) => PostsModel.fromMap(postMap)).toList();
    return posts;
  }
}
