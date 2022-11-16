import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:cpn_us/resources/assets_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class AboutUsDisplay extends StatefulWidget {
  final AboutUsModel? aboutUsModel;
  const AboutUsDisplay({super.key, this.aboutUsModel});

  @override
  State<AboutUsDisplay> createState() => _AboutUsDisplayState();
}

class _AboutUsDisplayState extends State<AboutUsDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(ImageAssets.splashLogo),
          height: AppSize.s280,
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.aboutUsModel!.response!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p25),
                child: Text(
                  parse(widget.aboutUsModel!.response![index].description!)
                      .body!
                      .text,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
