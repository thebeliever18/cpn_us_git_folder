import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:dartz/dartz.dart';
abstract class EventRepository {
  Future<Either<Failures?,EventModel?>?>? getEventData(EventModel? EventModel);
  Future<Either<Failures?,DownloadModel?>?>? getDownloadData(DownloadModel? downloadModel);
}