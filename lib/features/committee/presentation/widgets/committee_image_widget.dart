import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/features/committee/presentation/widgets/committee_display.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CommitteeImageWidget extends StatelessWidget {
  const CommitteeImageWidget({
    Key? key,
    required this.widget,
    required this.ind,
  }) : super(key: key);

  final CommitteeDisplay widget;
  final int ind;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SizedBox(
            height:
                MediaQuery.of(context).size.height / 2,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: ApiConstant.committeeImageUrl +
                  widget.committeeModel!.response![ind]
                      .image!,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: AppPadding.p8),
              color: Colors.transparent,
               height: 55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width-50,
                    child: Text(
                      widget.committeeModel!.response![ind]
                          .membername!,
                          style: Theme.of(context).textTheme.headline5,
                          
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-100,
                    height: 1,color: ColorManager.primary,),
                    SizedBox(height: 4,),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height:1,color: ColorManager.primary,)
                ],
              ),
            ),
          ),
        ],
      );
  }
}