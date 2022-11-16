import 'dart:convert';

import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:dio/dio.dart';


abstract class NoticesRemoteDataSource{
  ////calls the {Notices} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getNoticesData(NoticesModel? NoticesModel);
}


class NoticesRemoteDataSourceImpl implements NoticesRemoteDataSource{
  final Dio? dio;
  NoticesRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getNoticesData(NoticesModel? noticesModel) {
    return _getNoticesDataFromUrl(ApiConstant.notice,noticesModel);
  }
  
  Future<dynamic>? _getNoticesDataFromUrl(String url,NoticesModel? noticesModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return NoticesModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
}