import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knovator_task/bloc/post_by_id_bloc/post_by_id_state.dart';
import 'package:knovator_task/widgets/text_widget.dart';
import '../bloc/post_by_id_bloc/post_by_id_bloc.dart';
import '../bloc/post_by_id_bloc/post_by_id_event.dart';

class PostDetailScreen extends StatefulWidget {
  final int id;
  const PostDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    context.read<PostByIdBloc>().add(PostData(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Post Detail screen'),
      ),
      body: BlocBuilder<PostByIdBloc, PostByIdState>(
          builder: (BuildContext context, PostByIdState state) {
        if (state is PostByIdLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostByIdStateSuccess) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  text: 'Title : ${state.postIdModel.title}',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Body : ${state.postIdModel.body}',
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}
