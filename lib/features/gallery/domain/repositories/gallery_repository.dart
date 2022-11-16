import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:dartz/dartz.dart';
abstract class GalleryRepository {
  Future<Either<Failures?,GalleryModel?>?>? getGalleryData(GalleryModel? galleryModel);
  Future<Either<Failures?,ImagesModel?>?>? getImagesData(ImagesModel? imagesModel);
}