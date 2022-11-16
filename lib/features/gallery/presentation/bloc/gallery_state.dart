part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();
  
  @override
  List<Object?> get props => [];
}

class GalleryLoading extends GalleryState {}
class GalleryInitial extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final int? pageIndex;
  final GalleryModel? galleryModel;
  final ImagesModel? imagesModel;

  const GalleryLoaded({this.galleryModel,this.pageIndex,this.imagesModel});
  @override
  List<Object?> get props => [galleryModel,pageIndex,imagesModel];
}

class GalleryNotLoaded extends GalleryState {
  final String message;
  const GalleryNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}



class ImagesLoading extends GalleryState {}
class ImagesInitial extends GalleryState {}

class ImagesLoaded extends GalleryState {

  final ImagesModel? imagesModel;
  const ImagesLoaded({this.imagesModel,});
  @override
  List<Object?> get props => [imagesModel,];
}

class ImagesNotLoaded extends GalleryState {
  final String message;
  const ImagesNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}