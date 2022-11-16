
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/features/gallery/domain/usecases/get_gallery_data.dart';
import 'package:cpn_us/features/gallery/domain/usecases/get_images_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';


class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetGalleryData getGalleryData;
  final GetImagesData getImagesData;
  
  GalleryModel? _datum;
  GalleryModel? get datum => _datum;

  GalleryBloc({required this.getGalleryData,required this.getImagesData}) : super(GalleryLoading()) {
    on<TriggerGalleryPostApi>(_onTriggerGalleryPostApi);
    on<GetImages>(_getImages);
    on<NavigateBack>(_onNavigateBack);
  }

  void _onTriggerGalleryPostApi(
      TriggerGalleryPostApi event, Emitter<GalleryState> emit) async {
    final failureOrGalleryData = await getGalleryData(
        GetGalleryParams(galleryModel: event.galleryModel));
    emit(_eitherLoadedOrErrorState(failureOrGalleryData));
  }

  GalleryState _eitherLoadedOrErrorState(
      Either<Failures?, GalleryModel?>? failureOrGalleryData) {
    return failureOrGalleryData!.fold(
        (failure) => GalleryNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (galleryModel) {
          _datum=galleryModel;
      return GalleryLoaded(galleryModel:galleryModel);
    });
  }

  void _getImages(GetImages event, Emitter<GalleryState> emit) async{
    //emit(ImagesLoading());
     final failureOrImagesData = await getImagesData(
        GetImagesParams(imagesModel: event.imagesModel));
    emit(_eitherLoadedOrErrorStateImages(failureOrImagesData));
  }


  GalleryState _eitherLoadedOrErrorStateImages(
      Either<Failures?, ImagesModel?>? failureOrImagesData) {
    return failureOrImagesData!.fold(
        (failure) => ImagesNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (imagesModel) {
      return GalleryLoaded(galleryModel:datum,imagesModel:imagesModel);
      //ImagesLoaded(imagesModel:imagesModel);
    });
  }

  void _onNavigateBack(NavigateBack event, Emitter<GalleryState> emit) {
    emit(GalleryLoaded(galleryModel:datum));
  }
}
