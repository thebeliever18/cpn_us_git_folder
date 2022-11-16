import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/cpn_us_app_bar.dart';
import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/images_display.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesView extends StatefulWidget {
  final String title;
  final String id;
  const ImagesView({super.key, required this.title, required this.id});

  @override
  State<ImagesView> createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesView> {
  final NavigationHelper navigationHelper = sl<NavigationHelper>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GalleryBloc>(context).add(GetImages(
        imagesModel:
            ImagesModel(response: [ImageResponse(id: int.parse(widget.id))])));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<GalleryBloc>(context).add(NavigateBack());
        navigationHelper.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: CpnUsAppBar(
            goBack: true,
            appBarCustomTitle: widget.title,
            onTap: () {
              BlocProvider.of<GalleryBloc>(context).add(NavigateBack());
              navigationHelper.pop();
            },
          ),
          body: BlocBuilder<GalleryBloc, GalleryState>(
            builder: (context, state) {
              if (state is ImagesLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              } else if (state is ImagesLoaded) {
                return isImageEmpty(state);
              } else if (state is ImagesNotLoaded) {
                return CpnUsMessageDisplay(message: state.message);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  StatelessWidget isImageEmpty(ImagesLoaded state) {
    if(state.imagesModel!.response!.isEmpty){
      return CpnUsMessageDisplay(message: 'No images in ${widget.title}');
    }else{
      return ImagesDisplay(
      imagesModel: state.imagesModel,
    );
    }
  }
}
