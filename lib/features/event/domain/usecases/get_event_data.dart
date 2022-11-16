import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:cpn_us/features/event/domain/repositories/event_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetEventData implements UseCase<EventModel?,GetEventParams?>{
  final EventRepository? repository;
  GetEventData(this.repository);

  @override
  Future<Either<Failures?,EventModel?>?>? call(GetEventParams? params) async{
    return await repository!.getEventData(params!.eventModel);
  }
}

class GetEventParams extends Equatable{
  final EventModel? eventModel;
  const GetEventParams({required this.eventModel});

  @override
  List<Object?> get props => [eventModel];
}