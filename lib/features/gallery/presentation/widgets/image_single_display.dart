import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/cpn_us_app_bar.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:flutter/material.dart';

class ImageSingleDisplay extends StatefulWidget {
  final List<ImageResponse>? response;
  final int index;
  const ImageSingleDisplay(
      {super.key, required this.response, required this.index});

  @override
  State<ImageSingleDisplay> createState() => _ImageSingleDisplayState();
}

class _ImageSingleDisplayState extends State<ImageSingleDisplay> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.index);
  }

  void onPageChanged(int value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CpnUsAppBar(
        goBack: true,
        appBarCustomTitle: '',
        onTap: () {
          final NavigationHelper navigationHelper = sl<NavigationHelper>();
          navigationHelper.pop();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              child: PageView.builder(
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: onPageChanged,
                  itemCount: widget.response!.length,
                  itemBuilder: (context, i) {
                    var url = widget.response![i].url;
                    return CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: ApiConstant.galleryImageUrl + url!,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
