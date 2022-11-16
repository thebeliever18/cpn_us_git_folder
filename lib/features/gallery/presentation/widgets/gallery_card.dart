
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class GalleryCard extends StatelessWidget {
  final String title;
  final String description;
  final String? file;

  const GalleryCard(
      {Key? key,
      required this.title,
      required this.description,
      this.file,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s22,
        ),
        Container(
          height: AppSize.s100,
          width: MediaQuery.of(context).size.width - AppSize.s15,
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
                              flex: 3,
                                child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              
                              title,
                              style: Theme.of(context).textTheme.headline2
                            )),
                          
                           
                            Expanded(
                              flex: 5,
                                child: Text(
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              parse(description).body!.text,
                              style: Theme.of(context).textTheme.bodyText1
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                    width: AppSize.s100,
                                    height: AppSize.s30,
                                    decoration: BoxDecoration(
                                        color: ColorManager.skyBlue2,
                                        border:
                                            Border.all(color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s4)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                      ],
                                    )),
                              )
                            ],
                          ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}