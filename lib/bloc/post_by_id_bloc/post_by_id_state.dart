import 'package:equatable/equatable.dart';
import 'package:knovator_task/models/post_id_model.dart';
import '../../models/common_response_model.dart';

abstract class PostByIdState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostByIdStateInitial extends PostByIdState {}

class PostByIdLoading extends PostByIdState {}

class PostByIdStateSuccess extends PostByIdState {
  final PostIdModel postIdModel;
  PostByIdStateSuccess({required this.postIdModel});

  @override
  List<Object?> get props => [postIdModel];
}

class PostByIdStateFail extends PostByIdState {
  final CommonResponseModel commonResponseModel;

  PostByIdStateFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
