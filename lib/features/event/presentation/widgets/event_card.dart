import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/presentation/bloc/event_bloc.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String? file;
  final String date;

  const EventCard(
      {Key? key,
      required this.title,
      required this.description,
      this.file,
      required this.date,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s20,
        ),
        Container(
          height: AppSize.s130,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                                child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              title,
                              style: Theme.of(context).textTheme.headlineLarge
                            )),
                            SizedBox(height: AppSize.s8,),
                            Text(date,style: Theme.of(context).textTheme.caption,),
                            SizedBox(height: AppSize.s8,),
                            Expanded(
                              flex: 5,
                                child: Text(
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              parse(description).body!.text,
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                          ],
                        ),
                      ),
                      IconButton(icon: Icon(Icons.remove_red_eye_outlined,),
                      onPressed: (){
                        final NavigationHelper navigationHelper = sl<NavigationHelper>();
                        navigationHelper.navigateTo(
                          Routes.cpnUsWebView,
                          arguments: [
                            ApiConstant.eventViewUrl+file!,
                          file]);
                      },
                      ),
                      SizedBox(
                        width: AppSize.s12,
                      ),
                      IconButton(icon: Icon(Icons.cloud_download_outlined,),
                      onPressed: (){
                        BlocProvider.of<EventBloc>(context).add(
                          DownloadFile(downloadModel: DownloadModel(
                            downloadFileName:file,
                          ),),);
                      },
                      ),
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



// Expanded(
                            //   child: Container(
                            //       width: AppSize.s100,
                            //       height: AppSize.s30,
                            //       decoration: BoxDecoration(
                            //           color: ColorManager.skyBlue2,
                            //           border:
                            //               Border.all(color: Colors.transparent),
                            //           borderRadius:
                            //               BorderRadius.circular(AppSize.s4)),
                            //       child: Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         children: [
                            //           Center(
                            //               child: Text(
                            //            'Download file',
                            //             style: Theme.of(context).textTheme.headline5,
                            //           )),
                            //           SizedBox(height: AppSize.s1_5,),
                            //           Icon(Icons.download_outlined,color: Colors.white,)
                            //         ],
                            //       )),
                            // )