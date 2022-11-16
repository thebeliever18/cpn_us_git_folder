import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/gallery/data/models/images_model.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class ImagesDisplay extends StatelessWidget {
  const ImagesDisplay({super.key, this.imagesModel,this.description});
  final ImagesModel? imagesModel;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s6,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:AppPadding.p24,),
          child: Wrap(
            children: [
              Text(
                  parse(description!).body!.text,style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.justify,),
            ],
          ),
        ),
        Expanded(
          flex: 12,
          child: GridView.count(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
              children: List.generate(
                imagesModel!.response!.length,
                (index) => GestureDetector(
                  onTap: () {
                    final NavigationHelper navigationHelper = sl<NavigationHelper>();
                    navigationHelper.navigateTo(Routes.imageSingleDisplay,
                        arguments: [imagesModel!.response!,index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p4,vertical: AppPadding.p4,),
                    child: 
                    //Image(image: AssetImage(ImageAssets.splashLogo),fit: BoxFit.cover,)
                    CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: ApiConstant.galleryImageUrl +
                            imagesModel!.response![index].url!)
                            ,
                  ),
                ),
                //Image(image: AssetImage(ImageAssets.splashLogo),fit: BoxFit.cover,)
              )),
        ),
      ],
    );
  }
}
