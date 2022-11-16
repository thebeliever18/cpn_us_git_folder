import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetImagesData implements UseCase<ImagesModel?,GetImagesParams?>{
  final GalleryRepository? repository;
  GetImagesData(this.repository);

  @override
  Future<Either<Failures?,ImagesModel?>?>? call(GetImagesParams? params) async{
    return await repository!.getImagesData(params!.imagesModel);
  }
}

class GetImagesParams extends Equatable{
  final ImagesModel? imagesModel;
  const GetImagesParams({required this.imagesModel});

  @override
  List<Object?> get props => [imagesModel];
}