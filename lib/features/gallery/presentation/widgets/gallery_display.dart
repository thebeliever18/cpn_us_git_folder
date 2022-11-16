import 'dart:developer';

import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/cpn_us_tab_bar.dart';
import 'package:cpn_us/core/widgets/cpn_us_tab_bar_container.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/gallery/data/models/gallery_model.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/gallery_card.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/images_display.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/images_view.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryDisplay extends StatefulWidget {
  final GalleryModel? galleryModel;
  final ImagesModel? imagesModel;
  const GalleryDisplay({super.key, this.galleryModel, this.imagesModel});

  @override
  State<GalleryDisplay> createState() => _GalleryDisplayState();
}

class _GalleryDisplayState extends State<GalleryDisplay>
    with TickerProviderStateMixin {
  TabController? _controller;
  List<GalleryModelResponse>? _galleryModelResponse;
  ImagesModel? _imagesModel;

  @override
  void initState() {
    super.initState();
    forInitState();
  }

 

  @override
  void didUpdateWidget(covariant GalleryDisplay oldWidget) {
    _imagesModel = widget.imagesModel;
    super.didUpdateWidget(oldWidget);
    log('hello');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if(state is SearchLoaded){
          forSearchLoaded(state);
        }else if(state is SearchInitial){
          forSearchInitial(state);
        }
      },
      builder: (context, state) {
        return CpnUsTabBar(
          length: _galleryModelResponse!.length,
          tabs: List.generate(
              _galleryModelResponse!.length,
              (index) => CpnUsTabBarContainer(
                  title: _galleryModelResponse![index].name!)),
          controller: _controller,
          children: List.generate(
              _galleryModelResponse!.length,
              (index) => _imagesModel == null
                  ? Center(child: CircularProgressIndicator())
                  : _imagesModel!.response!.isEmpty
                      ? Center(child: Text('No images in this gallery'))
                      : ImagesDisplay(
                          imagesModel: widget.imagesModel,
                          description:
                              _galleryModelResponse![index].description!)),
        );
      },
    );

    // ListView.builder(
    //   physics: BouncingScrollPhysics(),
    //   scrollDirection: Axis.vertical,
    //   itemCount: widget.galleryModel!.response!.length,
    //   padding: EdgeInsets.symmetric(horizontal: AppPadding.p22),
    //   itemBuilder: (context, index) {
    //     var data = widget.galleryModel!.response![index];
    //     return GestureDetector(
    //       onTap: (){
    //         final NavigationHelper navigationHelper = sl<NavigationHelper>();
    //         navigationHelper.navigateTo(Routes.images,arguments: [data.name,data.id]);
    //       },
    //       child: GalleryCard(
    //         title: data.name!,
    //         description: data.description!,
    //       ),
    //     );
    //   },
    // );
  }

  void forSearchInitial(SearchInitial state) {
    _galleryModelResponse = widget.galleryModel!.response!;
    _controller = TabController(
    length: _galleryModelResponse!.length, vsync: this,);
    if(state.searchValue!=''){
      getImages(index: _controller!.index);
    }
    
    _controller!.addListener(() {
        _imagesModel = null;
        getImages(index: _controller!.index);
        setState(() {});
      });
  }

  void forSearchLoaded(SearchLoaded state) {
    
    searchGalleryTopic(state);
    
    
    _controller = TabController(
    length: _galleryModelResponse!.length, vsync: this,);
    
    if(state.searchValue!=""){
      getImages(index: _controller!.index);
    }

   
      _controller!.addListener(() {
        _imagesModel = null;
        getImages(index: _controller!.index);
        setState(() {});
      });
   
    
  }

   void forInitState() {
    _controller = TabController(
        length: widget.galleryModel!.response!.length, vsync: this);
    _galleryModelResponse = widget.galleryModel!.response!;
    getImages(index: 0);
    _controller!.addListener(() {
      _imagesModel = null;
      getImages(index: _controller!.index);
      setState(() {});
    });
  }

  void getImages({required int index}) {
    if(_galleryModelResponse!.isNotEmpty){
      BlocProvider.of<GalleryBloc>(context).add(GetImages(
        imagesModel: ImagesModel(response: [
      ImageResponse(id: _galleryModelResponse![index].id)
    ])));
    }
    
  }
  
  void searchGalleryTopic(SearchLoaded state) {
    List<GalleryModelResponse>? galleryModelResponse = widget.galleryModel!.response!.where((galleryModel) {
      String title = galleryModel.name!.toLowerCase();
      String description = galleryModel.description!.toLowerCase();
      String searchValue = state.searchValue.toLowerCase();

      return title.contains(searchValue) || description.contains(searchValue);
    }).toList();
    _galleryModelResponse = galleryModelResponse;
  }
}
