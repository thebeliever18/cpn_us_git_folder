import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:cpn_us/features/video/presentation/bloc/video_bloc.dart';
import 'package:cpn_us/features/video/presentation/widgets/video_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<VideoBloc>(context).add(TriggerVideoPostApi(videoModel: VideoModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (c, state) {
      if (state is VideoLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Center(child: CircularProgressIndicator()),
          ],
        );
      }else if(state is VideoLoaded){
        return VideoDisplay(videoModel: state.videoModel,);
      }else if(state is VideoNotLoaded){
        return CpnUsMessageDisplay(message: state.message);
      }return const Center(child: CircularProgressIndicator());
    });
  }
}
