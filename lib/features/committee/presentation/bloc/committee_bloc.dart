
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/committee/data/models/committee_model.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:cpn_us/features/committee/domain/usecases/get_committee_data.dart';
import 'package:cpn_us/features/committee/domain/usecases/get_committee_title.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'committee_event.dart';
part 'committee_state.dart';

class CommitteeBloc extends Bloc<CommitteeEvent, CommitteeState> {
  final GetCommitteeData getCommitteeData;
  final GetCommitteeTitleData getCommitteeTitleData;

  CommitteeTitleModel? _committeeTitleModel;
  CommitteeTitleModel? get committeeTitleModel => _committeeTitleModel;

  CommitteeBloc(
      {required this.getCommitteeData, required this.getCommitteeTitleData})
      : super(CommitteeTitleLoading()) {
    on<TriggerCommitteePostApi>(_onTriggerCommitteePostApi);
    on<GetCommitteeTitle>(_onGetCommitteeTitle);
  }

  void _onTriggerCommitteePostApi(
      TriggerCommitteePostApi event, Emitter<CommitteeState> emit) async {
        emit(CommitteeLoading(committeeTitleModel: committeeTitleModel));
    final failureOrCommitteeData = await getCommitteeData(
        GetCommitteeParams(committeeModel: event.committeeModel));
    emit(_eitherLoadedOrErrorState(failureOrCommitteeData));
  }

  CommitteeState _eitherLoadedOrErrorState(
      Either<Failures?, CommitteeModel?>? failureOrCommitteeData) {
    return failureOrCommitteeData!.fold(
        (failure) => CommitteeNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (committeeModel) {
      return CommitteeLoaded(
      committeeModel: committeeModel,
      committeeTitleModel: this.committeeTitleModel
      );
    });
  }

  void _onGetCommitteeTitle(
      GetCommitteeTitle event, Emitter<CommitteeState> emit) async {
    final failureOrCommitteeTitleData = await getCommitteeTitleData(
        GetCommitteeTitleParams(
            committeeTitleModel: event.committeeTitleModel));
    emit(_eitherLoadedOrErrorStateCommitteeTitle(failureOrCommitteeTitleData));
  }

  CommitteeState _eitherLoadedOrErrorStateCommitteeTitle(
      Either<Failures?, CommitteeTitleModel?>? failureOrCommitteeTitleData) {
    return failureOrCommitteeTitleData!.fold(
        (failure) => CommitteeTitleNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (committeeTitleModel) {
      _committeeTitleModel = committeeTitleModel;
      return CommitteeTitleLoaded(committeeTitleModel: committeeTitleModel);
    });
  }
}
