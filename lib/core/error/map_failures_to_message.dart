import 'package:cpn_us/core/constants/app_constant.dart';
import 'package:cpn_us/core/error/failures.dart';



class MapFailuresToMessage{
  static String mapFailureToMessage({required Failures? failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppConstant.serverFailureMessage;
      case CacheFailure:
        return AppConstant.cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
