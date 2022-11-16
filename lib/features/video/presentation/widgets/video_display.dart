import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/leader_display_card.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoDisplay extends StatefulWidget {
  final VideoModel? videoModel;
  const VideoDisplay({super.key, this.videoModel});

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  List<GridResponse>? _response;

  @override
  void initState() {
    super.initState();
    _response = widget.videoModel!.response!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if(state is SearchLoaded){
          searchVideo(state);
        }else if(state is SearchInitial){
          _response = widget.videoModel!.response!;
        }
      },
      builder: (context, state) {
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (200 / 270),
          ),
          itemCount: _response!.length,
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p12,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p12, horizontal: AppPadding.p12),
              child: LeaderDisplayCard(
                image: ApiConstant.videoImageUrl + _response![index].image!,
                position: _response![index].videolinked!,
                name: _response![index].title!,
                hasVideo: true,
              ),
            );
          },
        );
      },
    );
  }
  
  void searchVideo(SearchLoaded state) {
    List<GridResponse>? gridResponse = widget.videoModel!.response!.where(
      (gridModel) {
        String title = gridModel.title!.toLowerCase();
        String searchValue = state.searchValue.toLowerCase();
        return title.contains(searchValue);
      })
      .toList();
      _response = gridResponse;
  }
}
