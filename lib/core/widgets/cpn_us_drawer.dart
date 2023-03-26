import 'package:cpn_us/core/constants/app_json.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/menu_items.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/change_password/presentation/pages/change_password_screen.dart';
import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:cpn_us/resources/assets_manager.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/strings_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/donation/presentation/pages/donation_view.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/more/presentation/view/MoreView.dart';
import '../../features/register/presentation/pages/register_view.dart';
import '../../resources/routes_manager.dart';
import '../error/toast_response.dart';

// ignore: must_be_immutable
class CpnUsDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  CpnUsDrawer({super.key,required this.scaffoldKey});

  final NavigationHelper navigationHelper = sl<NavigationHelper>();
  bool isActivate = false;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.backgroundColor,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: AppSize.s100,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Row(
                children: [
                  const Image(
                    image: AssetImage(ImageAssets.splashLogo),
                    height: AppSize.s65,
                  ),
                  const SizedBox(
                    width: AppSize.s12,
                  ),
                  Text(
                    AppStrings.cpnUs.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
              ),
            ),
          ),
          MenuItems(
            menuTitle: AppStrings.news,
            menuIcon: Icons.home_outlined,
            
            onTap: () {
           
              
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 0,activate: !isActivate,appBarTitle: AppStrings.news));
              scaffoldKey.currentState!.closeDrawer();
            },
            index: 0,
          ),
          MenuItems(
            menuTitle: AppStrings.aboutUs,
            menuIcon: Icons.info_outline_rounded,
          
            onTap: () {
              //navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 1,activate: !isActivate,appBarTitle: AppStrings.aboutUs));
             scaffoldKey.currentState!.closeDrawer();
            },
            index: 1,
          ),
          MenuItems(
            menuTitle: AppStrings.notices,
            menuIcon: Icons.push_pin_outlined,
          
            onTap: () {
              //navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 2,activate: !isActivate,appBarTitle: AppStrings.notices));
              scaffoldKey.currentState!.closeDrawer();
            },
               index: 2,
          ),
           MenuItems(
            menuTitle: AppStrings.events,
            menuIcon: Icons.event_available_sharp,
               index: 3,
               onTap: () {
           
              
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 3,activate: !isActivate,appBarTitle: AppStrings.events));
              scaffoldKey.currentState!.closeDrawer();
            },
          ),
           MenuItems(
            menuTitle: AppStrings.videos,
            menuIcon: Icons.ondemand_video_sharp,
               index: 4,
               onTap: () {
           
              
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 4,activate: !isActivate,appBarTitle: AppStrings.videos));
              scaffoldKey.currentState!.closeDrawer();
            },
            
          ),
           MenuItems(
            menuTitle: AppStrings.gallery,
            menuIcon: Icons.photo_library_outlined,   
            
            onTap: () {
           
              
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 5,activate: !isActivate,appBarTitle: AppStrings.gallery));
              scaffoldKey.currentState!.closeDrawer();
            },
            index: 5,
          ),
           MenuItems(
            menuTitle: AppStrings.leaders,
            menuIcon: Icons.groups_outlined,
            onTap: () {
           
              
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 6,activate: !isActivate,appBarTitle: AppStrings.leaders));
              scaffoldKey.currentState!.closeDrawer();
            },
               index: 6,
          ),
          MenuItems(
              menuTitle: AppStrings.committee,
              menuIcon: Icons.badge_outlined,
                 index: 7,
                 onTap: () {
              BlocProvider.of<LandingBloc>(context)
                  .add(OnDrawerItemClicked(index: 7,activate: !isActivate,appBarTitle: AppStrings.committee));
              scaffoldKey.currentState!.closeDrawer();
            },
          ),
          if (AppJSON.logInfo.isNotEmpty)
            MenuItems(
              menuTitle: AppStrings.changePassword,
              menuIcon: Icons.password,
              index: 9,
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
              },
            ),
          if (AppJSON.logInfo.isNotEmpty)
            MenuItems(
              menuTitle: AppStrings.logout,
              menuIcon: Icons.logout,
              index: 8,
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                prefs.commit();

                AppJSON.logInfo = [];

                successToast("Logout success");
                navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
              },
            )
          else
            MenuItems(
              menuTitle: AppStrings.login,
              menuIcon: Icons.login,
              index: 9,
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
        ],
      ),
    );
  }
}

