import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetGalleryData implements UseCase<GalleryModel?,GetGalleryParams?>{
  final GalleryRepository? repository;
  GetGalleryData(this.repository);

  @override
  Future<Either<Failures?,GalleryModel?>?>? call(GetGalleryParams? params) async{
    return await repository!.getGalleryData(params!.galleryModel);
  }
}

class GetGalleryParams extends Equatable{
  final GalleryModel? galleryModel;
  const GetGalleryParams({required this.galleryModel});

  @override
  List<Object?> get props => [galleryModel];
}