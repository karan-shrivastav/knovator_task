import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knovator_task/bloc/local_database/local_database.dart';
import 'package:knovator_task/bloc/post_bloc/post_event.dart';
import 'package:knovator_task/bloc/post_bloc/post_state.dart';
import 'package:knovator_task/models/post_model.dart';
import '../../Services/api_service.dart';
import '../../models/common_response_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiService apiService = ApiService();
  final LocalDatabase localDatabase =
      LocalDatabase();
  PostModel postModel = PostModel();
  late CommonResponseModel? commonResponseModel;

  PostBloc() : super(PostStateInitial()) {
    on<PostList>((event, emit) async {
      try {
        emit(PostStateLoading());
        final response = await apiService.getPost('/posts');

        if (response.statusCode == 200) {
          List<dynamic> responseData = json.decode(response.body);

          List<PostModel> posts = postModelFromJson(json.encode(responseData));
          for (var post in posts) {
            await localDatabase.insertPost(post);
          }
          List<PostModel> localPosts = await localDatabase.getPosts();
          emit(PostStateSuccess(postModel: localPosts));
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          emit(PostStateFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(PostStateFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
      }
    });
  }
}

