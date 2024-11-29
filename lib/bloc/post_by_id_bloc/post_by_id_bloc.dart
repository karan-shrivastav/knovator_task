import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knovator_task/bloc/post_by_id_bloc/post_by_id_event.dart';
import 'package:knovator_task/bloc/post_by_id_bloc/post_by_id_state.dart';
import 'package:knovator_task/models/post_id_model.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../models/common_response_model.dart';

class PostByIdBloc extends Bloc<PostByIdEvent, PostByIdState> {
  ApiService apiService = ApiService();
  late PostIdModel postIdModel;
  late CommonResponseModel? commonResponseModel;

  PostByIdBloc() : super(PostByIdStateInitial()) {
    on<PostData>((event, emit) async {
      try {
        emit(PostByIdLoading());
        final response = await apiService.getPost('/posts/${event.id}');

        if (kDebugMode) {
          print("Get response  ${response.body}");
        }

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          postIdModel = PostIdModel.fromJson(responseData);

          emit(PostByIdStateSuccess(postIdModel: postIdModel));
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          emit(PostByIdStateFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(PostByIdStateFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
