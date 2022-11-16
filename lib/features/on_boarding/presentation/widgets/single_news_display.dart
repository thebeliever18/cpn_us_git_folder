import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/cpn_us_app_bar.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class SingleNewsDisplay extends StatelessWidget {
  final dynamic response;
  final String imageUrl;
  const SingleNewsDisplay({super.key, required this.response,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CpnUsAppBar(
        goBack: true,
        onTap: () {
          final NavigationHelper navigationHelper = sl<NavigationHelper>();
          navigationHelper.pop();
        },
        appBarCustomTitle: response.title,
      ),
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:AppPadding.p20),
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              response.title!,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: AppSize.s12,),
            CachedNetworkImage(
                imageUrl: imageUrl + response.image!),
                    SizedBox(height: AppSize.s12,),
            Text(parse(response.description!).body!.text,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
      ),
    );
  }
}
