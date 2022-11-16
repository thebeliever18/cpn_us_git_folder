import 'dart:convert';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:dio/dio.dart';


abstract class OurLeadersRemoteDataSource{
  ////calls the {OurLeaders} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getOurLeadersData(OurLeadersModel? ourLeadersModel);
}


class OurLeadersRemoteDataSourceImpl implements OurLeadersRemoteDataSource{
  final Dio? dio;
  OurLeadersRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getOurLeadersData(OurLeadersModel? ourLeadersModel) {
    return _getOurLeadersDataFromUrl(ApiConstant.ourleader,ourLeadersModel);
  }
  
  Future<dynamic>? _getOurLeadersDataFromUrl(String url,OurLeadersModel? ourLeadersModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return OurLeadersModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
}