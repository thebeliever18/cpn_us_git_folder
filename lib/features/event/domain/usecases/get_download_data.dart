import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';

import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/domain/repositories/event_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetDownloadData implements UseCase<DownloadModel?,GetDownloadParams?>{
  final EventRepository? repository;
  GetDownloadData(this.repository);

  @override
  Future<Either<Failures?,DownloadModel?>?>? call(GetDownloadParams? params) async{
    return await repository!.getDownloadData(params!.downloadModel);
  }
}

class GetDownloadParams extends Equatable{
  final DownloadModel? downloadModel;
  const GetDownloadParams({required this.downloadModel});

  @override
  List<Object?> get props => [downloadModel];
}