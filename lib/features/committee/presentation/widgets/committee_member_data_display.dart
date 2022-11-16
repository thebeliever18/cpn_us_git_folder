import 'package:cpn_us/features/committee/presentation/widgets/committee_display.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class CommitteeMemberDataDisplay extends StatelessWidget {
  const CommitteeMemberDataDisplay(
      {Key? key, required this.widget, required this.ind})
      : super(key: key);

  final CommitteeDisplay widget;
  final int ind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.committeeModel!.response![ind].position!,
            style: Theme.of(context).textTheme.headline2,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              SizedBox(width: AppSize.s4,),
              Text(
                widget.committeeModel!.response![ind].address!,
                    style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          SizedBox(height: AppSize.s4,),
          Row(
            children: [
               Icon(Icons.phone_outlined),
                SizedBox(width: AppSize.s4,),
              Text(
                widget.committeeModel!.response![ind].mobilenumber!,
                 style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          SizedBox(height: AppSize.s4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Icon(Icons.description_outlined),
                SizedBox(width: AppSize.s4,),
              Expanded(
                child: Text(
                  parse(widget.committeeModel!.response![ind].description!).body!.text,
                   style: Theme.of(context).textTheme.caption,
                   textAlign: TextAlign.justify,
                   overflow: TextOverflow.ellipsis,
                   maxLines: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}