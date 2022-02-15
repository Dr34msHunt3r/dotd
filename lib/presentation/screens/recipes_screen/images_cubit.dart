import 'package:bloc/bloc.dart';
import 'package:dotd/repository/image_repository/image_repository.dart';
import 'package:dotd/repository/image_repository/model/dto/image_dto.dart';
import 'package:meta/meta.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit({required this.imageRepository}) : super(ImagesInitial());

  final ImageRepository imageRepository;

  void fetchImages() {
    imageRepository.fetchImages().then((images) {
      emit(ImagesLoaded(images: images));
    });
  }

  void addImage(AppImage image) {
    final currentState = state;
    if(currentState is ImagesLoaded){
      final images = currentState.images;
      images.add(image);
      emit(ImagesLoaded(images: images));
    }
  }

  void deleteImage(AppImage image) {
    final currentState = state;
    if(currentState is ImagesLoaded){
      final images = currentState.images.where(
              (element) => element.id != image.id).toList();
      emit(ImagesLoaded(images: images));
    }
  }
  void updateImage(AppImage image) {
    final currentState = state;
    if(currentState is ImagesLoaded){
      final images = currentState.images.where(
              (element) => element.id != image.id).toList();
      images.add(image);
      emit(ImagesLoaded(images: images));
    }
  }
}
