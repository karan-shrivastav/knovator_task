import 'package:equatable/equatable.dart';
import 'package:knovator_task/models/post_model.dart';
import '../../models/common_response_model.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostStateInitial extends PostState {}

class PostStateLoading extends PostState {}

class PostStateSuccess extends PostState {
  final List<PostModel>  postModel;
  PostStateSuccess({required this.postModel});

  @override
  List<Object?> get props => [postModel];
}

class PostStateFail extends PostState {
  final CommonResponseModel commonResponseModel;

  PostStateFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
