import 'dart:convert';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:dio/dio.dart';


abstract class AboutUsRemoteDataSource{
  ////calls the {AboutUs} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getAboutUsData(AboutUsModel? AboutUsModel);
}


class AboutUsRemoteDataSourceImpl implements AboutUsRemoteDataSource{
  final Dio? dio;
  AboutUsRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getAboutUsData(AboutUsModel? aboutUsModel) {
    return _getAboutUsDataFromUrl(ApiConstant.aboutus,aboutUsModel);
  }
  
  Future<dynamic>? _getAboutUsDataFromUrl(String url,AboutUsModel? aboutUsModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return AboutUsModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
}