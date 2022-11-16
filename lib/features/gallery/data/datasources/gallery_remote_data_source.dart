import 'dart:convert';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:dio/dio.dart';


abstract class GalleryRemoteDataSource{
  ////calls the {Gallery} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getGalleryData(GalleryModel? galleryModel);
  Future<dynamic>? getImagesData(ImagesModel? imagesModel);
}


class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource{
  final Dio? dio;
  GalleryRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getGalleryData(GalleryModel? galleryModel) {
    return _getGalleryDataFromUrl(ApiConstant.galleryTitle,galleryModel);
  }

  @override
  Future? getImagesData(ImagesModel? imagesModel) {
    return _getImagesDataFromUrl(ApiConstant.image,imagesModel);
  }
  
  Future<dynamic>? _getGalleryDataFromUrl(String url,GalleryModel? galleryModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return GalleryModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }

  Future<dynamic>? _getImagesDataFromUrl(String url,ImagesModel? imagesModel) async{
    var dio = Dio();   

    var postData = imagesModel!.response!.first.toJson();  

    try{
      final response = await dio.post(url,data: postData);
      if(response.statusCode==200){
        return ImagesModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
}