import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/features/committee/presentation/widgets/committee_display.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CommitteeMemberCard extends StatelessWidget {
  const CommitteeMemberCard({
    Key? key,
    required this.widget,
    required this.ind,
  }) : super(key: key);

  final CommitteeDisplay widget;
  final int ind;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(AppSize.s4),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 1.5,
                blurRadius: 0.5,
                color: ColorManager.grey3)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s4),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 70,
              width: 70,
              imageUrl: ApiConstant.committeeImageUrl +
                  widget.committeeModel!.response![ind].image!,
            ),
          ),
          SizedBox(
            width: AppSize.s12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.committeeModel!.response![ind].membername!,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                widget.committeeModel!.response![ind].position!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                widget.committeeModel!.response![ind].address!,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                widget.committeeModel!.response![ind].mobilenumber!,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
