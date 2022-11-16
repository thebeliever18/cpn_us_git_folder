import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/date_time_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';

class NewsDisplay extends StatelessWidget {
  final News response;
  NewsDisplay({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s20,
        ),
        Container(
          height: AppSize.s160,
          width: MediaQuery.of(context).size.width - AppSize.s4,
          decoration: BoxDecoration(
            color: ColorManager.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(AppSize.s4),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  spreadRadius: 1.5,
                  blurRadius: 1.0,
                  color: ColorManager.grey3),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 6,
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  response.title!,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                )),
                            SizedBox(
                              height: AppSize.s1_5,
                            ),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  parse(response.description).body!.text,
                                  style: Theme.of(context).textTheme.caption,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s8,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                    height: AppSize.s200,
                                    fit: BoxFit.cover,
                                    imageUrl: ApiConstant.newsImageUrl +
                                        response.image!),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: AppSize.s30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'News',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        response.posteddatetime!.timeAgo,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      // Text(
                      //   '${response.posteddatetime!.year}-${response.posteddatetime!.day}-${response.posteddatetime!.month}',
                      //   style: Theme.of(context).textTheme.caption,
                      // ),
                      InkWell(
                          onTap: () {}, child: Icon(Icons.ios_share_outlined))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
