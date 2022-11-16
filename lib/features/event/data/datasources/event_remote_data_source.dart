import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/error/exceptions.dart';
import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:cpn_us/features/event/domain/entities/download.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';


abstract class EventRemoteDataSource{
  ////calls the {Event} endpoint.
  ////throws a [ServerException] for all error codes.
  Future<dynamic>? getEventData(EventModel? eventModel);
  Future<dynamic>? getDownloadData(DownloadModel? downloadModel);
}


class EventRemoteDataSourceImpl implements EventRemoteDataSource{
  final Dio? dio;
  EventRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<dynamic>? getEventData(EventModel? eventModel) {
    return _getEventDataFromUrl(ApiConstant.event,eventModel);
  }

  @override
  Future? getDownloadData(DownloadModel? downloadModel) {
     return _getDownloadDataFromUrl(ApiConstant.eventDownloadUrl,downloadModel);
  }
  
  Future<dynamic>? _getEventDataFromUrl(String url,EventModel? eventModel) async{
    var dio = Dio();   
    try{
      final response = await dio.get(url);
      if(response.statusCode==200){
        return EventModel.fromJson(json.decode(response.data));
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }


   Future<dynamic>? _getDownloadDataFromUrl(String url,DownloadModel? downloadModel) async{
    var dio = Dio();   
    try{
      var filepath = await getExternalStorageDirectory();
    
       log(filepath!.path.toString());
       
      
      final response = await dio.get(
        url+downloadModel!.downloadFileName!,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0
        )
        );
       
      
      if(response.statusCode==200){
        final file = File(filepath.path+'/'+downloadModel.downloadFileName!).openSync(mode: FileMode.write);
        file.writeFromSync(response.data);
        await file.close();
        OpenFile.open(file.path);
        return DownloadModel(
          downloadPercentage: '123', 
          downloadStatus:  DownloadStatus.success,
          );
      }
    }catch(e){
      return Future.value(ServerException());
    }
  }


  

  
  
}