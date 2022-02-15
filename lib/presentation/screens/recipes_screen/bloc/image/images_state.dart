part of 'images_cubit.dart';

@immutable
abstract class ImagesState {}

class ImagesInitial extends ImagesState {}
class ImagesLoaded extends ImagesState {
  final List<AppImage> images;

  ImagesLoaded({required this.images});
}

