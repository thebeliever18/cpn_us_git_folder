part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class TriggerGalleryPostApi extends GalleryEvent{
  final GalleryModel galleryModel;
  const TriggerGalleryPostApi({required this.galleryModel});
  @override
  List<Object?> get props => [galleryModel];
}


class GetImages extends GalleryEvent{
  final ImagesModel imagesModel;
  const GetImages({required this.imagesModel});
  @override
  List<Object?> get props => [imagesModel];
}


class NavigateBack extends GalleryEvent{

  const NavigateBack();
  @override
  List<Object?> get props => [];
}