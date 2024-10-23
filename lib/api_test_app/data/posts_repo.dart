// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:reverse_string/api_test_app/data/posts_model.dart';
import 'package:reverse_string/api_test_app/data/remote_datasource.dart';

abstract class PostsRepository {
  Future<List<PostsModel>> getPosts();
}

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDatasource _remoteDatasource;
  PostsRepositoryImpl(
    this._remoteDatasource,
  );

  @override
  Future<List<PostsModel>> getPosts() {
    return _remoteDatasource.getPosts();
  }
}
