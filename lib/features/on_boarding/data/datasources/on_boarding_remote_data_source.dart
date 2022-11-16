import 'dart:convert';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:dio/dio.dart';


abstract class OnBoardingRemoteDataSource{
  ////calls the {OnBoarding} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getOnBoardingData(OnBoardingModel? onBoardingModel);
}


class OnBoardingRemoteDataSourceImpl implements OnBoardingRemoteDataSource{
  final Dio? dio;
  OnBoardingRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getOnBoardingData(OnBoardingModel? onBoardingModel) {
    return _getOnBoardingDataFromUrl(ApiConstant.onBoarding,onBoardingModel);
  }
  
  Future<dynamic>? _getOnBoardingDataFromUrl(String url,OnBoardingModel? onBoardingModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return OnBoardingModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
}