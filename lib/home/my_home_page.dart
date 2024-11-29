import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knovator_task/bloc/post_bloc/post_bloc.dart';
import 'package:knovator_task/bloc/post_bloc/post_state.dart';
import '../bloc/post_bloc/post_event.dart';
import '../widgets/post_item_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home screen'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (BuildContext context, PostState state) {
          if (state is PostStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostStateSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.postModel.length,
              itemBuilder: (context, index) {
                var post = state.postModel[index];
                return PostItemWidget(post: post);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
