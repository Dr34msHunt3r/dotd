import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesInitial());
}
