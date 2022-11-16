import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class GalleryRepoImpl implements GalleryRepository{
  final GalleryRemoteDataSource? galleryRemoteDataSource;
  //TODO:[SPANDAN] final GalleryLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  GalleryRepoImpl(
    {
      required this.galleryRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,GalleryModel?>> _getGalleryData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteGalleryData = await getRemoteOrLocal();
        return Right(remoteGalleryData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, GalleryModel?>?>? getGalleryData(GalleryModel? galleryModel) async{
    return await _getGalleryData(() => galleryRemoteDataSource!.getGalleryData(galleryModel));
  }

  @override
  Future<Either<Failures?, ImagesModel?>?>? getImagesData(ImagesModel? imagesModel) async{
    return await _getImagesData(() => galleryRemoteDataSource!.getImagesData(imagesModel));
  }

  Future<Either<Failures,ImagesModel?>> _getImagesData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteImagesData = await getRemoteOrLocal();
        return Right(remoteImagesData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }
}