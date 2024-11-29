import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostList extends PostEvent {
  PostList();
  @override
  List<Object?> get props => [];
}
