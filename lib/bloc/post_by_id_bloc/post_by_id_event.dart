import 'package:equatable/equatable.dart';

abstract class PostByIdEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostData extends PostByIdEvent {
  final int id;
  PostData({required this.id});
  @override
  List<Object?> get props => [id];
}
