import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/leader_display_card.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:cpn_us/features/our_leaders/presentation/bloc/our_leaders_bloc.dart';
import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:cpn_us/resources/strings_manager.dart';

import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OurLeadersOnBoardingView extends StatefulWidget {
  const OurLeadersOnBoardingView({
    Key? key,
  }) : super(key: key);

  @override
  State<OurLeadersOnBoardingView> createState() =>
      _OurLeadersOnBoardingViewState();
}

class _OurLeadersOnBoardingViewState extends State<OurLeadersOnBoardingView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OurLeadersBloc>(context)
        .add(TriggerOurLeadersPostApi(ourLeadersModel: OurLeadersModel()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: AppSize.s8,
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  const Icon(
                    Icons.groups_outlined,
                    size: AppSize.s28,
                  ),
                  const SizedBox(
                    width: AppSize.s8,
                  ),
                  Text(
                    'Our leaders',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                BlocProvider.of<LandingBloc>(context).add(OnDrawerItemClicked(
                    index: 6, activate: true, appBarTitle: AppStrings.leaders));
              },
              child: Text(
                'View More',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            )),
          ],
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        BlocBuilder<OurLeadersBloc, OurLeadersState>(
          builder: (context, state) {
            if (state is OurLeadersLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.ourLeadersModel!.response!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p8,
                          horizontal:AppPadding.p14,
                          ),
                        child: LeaderDisplayCard(
                          name: state.ourLeadersModel!.response![index].name!,
                          image: ApiConstant.ourleaderImageUrl+state.ourLeadersModel!.response![index].image!,
                          position:
                              state.ourLeadersModel!.response![index].position!,
                        ),
                      );
                    }),
              );
            }
            return LinearProgressIndicator();
          },
        ),
      ],
    );
  }
}
