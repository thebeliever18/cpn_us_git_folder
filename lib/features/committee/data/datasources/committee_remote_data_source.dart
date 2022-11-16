import 'dart:convert';
import 'dart:developer';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/committee/data/models/committee_model.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:dio/dio.dart';


abstract class CommitteeRemoteDataSource{
  ////calls the {Committee} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getCommitteeData(CommitteeModel? committeeModel);
   Future<dynamic>? getCommitteeTitleData(CommitteeTitleModel? committeeTitleModel);
}


class CommitteeRemoteDataSourceImpl implements CommitteeRemoteDataSource{
  final Dio? dio;
  CommitteeRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getCommitteeData(CommitteeModel? committeeModel) {
    return _getCommitteeDataFromUrl(ApiConstant.committee,committeeModel);
  }

  @override
  Future? getCommitteeTitleData(CommitteeTitleModel? committeeTitleModel) {
     return _getCommitteeTitleDataFromUrl(ApiConstant.comitytitle,committeeTitleModel);
  }
  
  Future<dynamic>? _getCommitteeDataFromUrl(String url,CommitteeModel? committeeModel) async{
    var dio = Dio();   

    var data =committeeModel!.response!.first.toJson();
    log(data.toString());
    try{
      final response = await dio.post(url,
      data: committeeModel.response!.first.toJson()
      );
      if(response.statusCode==200){
        return CommitteeModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }

  Future<dynamic>? _getCommitteeTitleDataFromUrl(String url,CommitteeTitleModel? committeeTitleModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return CommitteeTitleModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }
  
  
}