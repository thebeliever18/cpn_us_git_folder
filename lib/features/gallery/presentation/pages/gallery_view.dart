import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/gallery_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
    
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GalleryBloc>(context).add(TriggerGalleryPostApi(galleryModel: GalleryModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
        builder: (c, state) {
        if (state is GalleryLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const[
              Center(child: CircularProgressIndicator()),
            ],
          );
        }else if(state is GalleryLoaded){
          return GalleryDisplay(galleryModel: state.galleryModel,imagesModel: state.imagesModel,);
        }else if(state is GalleryNotLoaded){
          return CpnUsMessageDisplay(message: state.message);
        }
        return const Center(child: CircularProgressIndicator());
      });
  }
}
