import 'package:cpn_us/core/widgets/cpn_us_app_bar.dart';
import 'package:cpn_us/core/widgets/cpn_us_drawer.dart';
import 'package:cpn_us/features/about_us/presentation/pages/about_us_view.dart';
import 'package:cpn_us/features/committee/presentation/pages/committee_view.dart';
import 'package:cpn_us/features/event/presentation/pages/event_view.dart';
import 'package:cpn_us/features/gallery/presentation/pages/gallery_view.dart';
import 'package:cpn_us/features/notices/presentation/pages/notices_view.dart';
import 'package:cpn_us/features/on_boarding/presentation/pages/on_boarding_view.dart';
import 'package:cpn_us/features/our_leaders/presentation/pages/our_leaders_view.dart';
import 'package:cpn_us/features/video/presentation/pages/video_view.dart';
import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool needSearch = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LandingBloc>(context).add(OnDrawerItemClicked(
        index: 0, activate: true, appBarTitle: AppStrings.news));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LandingBloc, LandingState>(
        listener: (context, state) {
          if (state is LandingIndexChanged) {
            if(state.index==1){
              needSearch=false;
            }else{
              needSearch=true;
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.backgroundColor,
            key: scaffoldKey,
            drawer: CpnUsDrawer(
              scaffoldKey: scaffoldKey,
            ),
            appBar: CpnUsAppBar(
              scaffoldKey: scaffoldKey,
              needSearch: needSearch,
            ),
            body: buildBody(context));},
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(builder: (context, state) {
      if (state is LandingIndexChanged) {
        return [
          OnBoardingView(),
          AboutUsView(),
          NoticesView(),
          EventView(),
          VideoView(),
          GalleryView(),
          OurLeadersView(),
          CommitteeView(),
          OurLeadersView(),
          OurLeadersView(),
        ].elementAt(state.index);
      } else if (state is LandingInitial) {
        BlocProvider.of<LandingBloc>(context).add(OnDrawerItemClicked(
            index: 0, activate: true, appBarTitle: AppStrings.news));
      }
      return Center(child: Text('Error'));
    });
  }
}
