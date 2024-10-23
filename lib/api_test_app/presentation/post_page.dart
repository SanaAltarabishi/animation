import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reverse_string/api_test_app/core/service/network_service.dart';
import 'package:reverse_string/api_test_app/data/posts_model.dart';
import 'package:reverse_string/api_test_app/data/posts_repo.dart';
import 'package:reverse_string/api_test_app/data/remote_datasource.dart';
import 'package:reverse_string/api_test_app/presentation/cubit/posts_cubit.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
        //! service locater get it !! injector tool
        PostsRepositoryImpl(
          RemoteDatasourceImpl(
            networkService: NetworkServiceImpl(),
          ),
        ),
      )..loadPosts(),
      child: Scaffold(body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostsError) {
          _showErrorDialog(context);
        }
      },
      builder: (context, state) {
        if (state is PostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostsLoaded) {
          return _buildPostsList(state);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildPostsList(PostsLoaded state) {
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (_, index) {
        final post = state.posts[index];
        return PostItem(
          post: post,
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('an error occurred'),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final PostsModel post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(post.id.toString()),
      title: Text(post.title),
      subtitle: Text(post.body),
    );
  }
}
