import 'dart:convert';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:dio/dio.dart';


abstract class VideoRemoteDataSource{
  ////calls the {Video} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getVideoData(VideoModel? videoModel);
}


class VideoRemoteDataSourceImpl implements VideoRemoteDataSource{
  final Dio? dio;
  VideoRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getVideoData(VideoModel? VideoModel) {
    return _getVideoDataFromUrl(ApiConstant.video,VideoModel);
  }
  
  Future<dynamic>? _getVideoDataFromUrl(String url,VideoModel? videoModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return VideoModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
}