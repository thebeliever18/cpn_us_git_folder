import 'package:equatable/equatable.dart';

enum DownloadStatus{initial,progress,success,paused,failed}
class Download extends Equatable{
  final String? downloadFileName;
  final String? downloadPercentage;
  final DownloadStatus? downloadStatus;

  Download({
    this.downloadFileName,
   this.downloadPercentage,
   this.downloadStatus
    }
  );

  @override
  List<Object?> get props => [
    downloadFileName,
      downloadPercentage,
      downloadStatus
  ];

}