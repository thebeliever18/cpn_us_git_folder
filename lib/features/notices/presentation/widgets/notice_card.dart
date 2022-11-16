import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import '../../data/models/notices_model.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    Key? key,
    required this.response,
     required this.index,
  }) : super(key: key);

  final List<NoticeResponse> response;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorManager.grey3,
        borderRadius: BorderRadius.circular(
          AppSize.s14,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                AppSize.s14,
              ),
              topRight: Radius.circular(
                AppSize.s14,
              ),
            ),
            child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                imageUrl:
                    ApiConstant.noticeImageUrl + response[index].image!),
          ),
          Padding(
              padding: const EdgeInsets.all(
                AppPadding.p8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  response[index].title!,
                  style: Theme.of(context).textTheme.headline2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  ),
                  SizedBox(
                    height: AppSize.s4,
                  ),
                  Text(parse(response[index].description!).body!.text,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
