import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/constants/app_constant.dart';
import 'package:cpn_us/core/error/toast_response.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/login/presentation/pages/login_screen.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/news_display.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/our_leaders_onboarding_view.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/strings_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_json.dart';
import '../../../../landing/bloc/landing_bloc.dart';
import '../../../../resources/color_manager.dart';
import '../../../donation/presentation/pages/donation_view.dart';
import '../../../more/presentation/view/MoreView.dart';
import '../../../register/presentation/pages/register_view.dart';
import '../../../scanner/presentation/view/scanner_screen.dart';

class OnBoardingDisplay extends StatefulWidget {
  final OnBoardingModel? onBoardingModel;
  const OnBoardingDisplay({super.key, this.onBoardingModel});

  @override
  State<OnBoardingDisplay> createState() => _OnBoardingDisplayState();
}

class _OnBoardingDisplayState extends State<OnBoardingDisplay> {

  final NavigationHelper navigationHelper = sl<NavigationHelper>();
  bool isActivate = false;

  List<News>? _news;

  @override
  void initState() {
    super.initState();
    _news = widget.onBoardingModel!.response!.news!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
          if (state is SearchLoaded) {
            searchNews(state);
          }
      },
      builder: (context, state) {
        if (state is SearchLoaded) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children: List<Widget>.generate(
              _news!.length,
              (index) => GestureDetector(
                onTap: () {
                  final NavigationHelper navigationHelper =
                      sl<NavigationHelper>();
                  navigationHelper.navigateTo(Routes.singleNewsDisplay,
                      arguments: _news![index]);
                },
                child: NewsDisplay(response: _news![index]),
              ),
            ),
          );
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:AppPadding.p12),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    AppStrings.welcomeMessage,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p1),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        itemCount: widget.onBoardingModel!.response!.banner!.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s6),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: AppSize.s200,
                                width: MediaQuery.of(context).size.width,
                                imageUrl: ApiConstant.bannerImageUrl +
                                    widget.onBoardingModel!.response!.banner![index]
                                        .image!),
                          );
                        })),
                  ),
                ),

                if (AppJSON.logInfo.isEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: double.infinity,
                    height: 190.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/ribbon.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('सदस्य बन्नुहोस्', style: TextStyle(
                              fontSize: 16.0, color: ColorManager.themeBlueColor, fontWeight: FontWeight.normal)),
                          Text('सदस्यता आवेदन फारम', style: TextStyle(
                              fontSize: 21.0, color: ColorManager.themeBlueColor, fontWeight: FontWeight.bold)),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: 130.0,
                            height: 40.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorManager.themeRedColor,// foreground
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
                                },
                                child: Text('सामेल हुनुहोस ', style: TextStyle(
                                    fontSize: 16.0
                                ))),
                          )
                        ],
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 20.0),

                // new code
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200]!,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    crossAxisCount: 4,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      AppJSON.myMenuList.length, (index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 1,activate: !isActivate,appBarTitle: AppStrings.aboutUs));
                          } else if (index == 1) {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 6,activate: !isActivate,appBarTitle: AppStrings.committee));
                          } else if (index == 2) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DonationView()));
                          } else if (index == 3) {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 5,activate: !isActivate,appBarTitle: AppStrings.events));
                          } else if (index == 4) {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 5,activate: !isActivate,appBarTitle: AppStrings.gallery));
                          } else if (index == 5) {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 6,activate: !isActivate,appBarTitle: AppStrings.leaders));
                          } else if (index == 6) {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 2,activate: !isActivate,appBarTitle: AppStrings.notices));
                          } else {
                            BlocProvider.of<LandingBloc>(context)
                                .add(OnDrawerItemClicked(index: 4,activate: !isActivate,appBarTitle: AppStrings.videos));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Image.asset(AppJSON.myMenuList[index]['image'], height: 40.0),
                              ),
                              Text(AppJSON.myMenuList[index]['title'], style: TextStyle(fontSize: 13.0, color: Colors.black87, fontWeight:
                              FontWeight.bold), maxLines: 1, textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      );
                    },),
                  ),
                ),

                Column(
                  children: List<Widget>.generate(
                    widget.onBoardingModel!.response!.news!.length,
                        (index) => GestureDetector(
                      onTap: () {
                        final NavigationHelper navigationHelper =
                        sl<NavigationHelper>();
                        navigationHelper.navigateTo(Routes.singleNewsDisplay,
                            arguments:
                            widget.onBoardingModel!.response!.news![index]);
                      },
                      child: NewsDisplay(
                          response: widget.onBoardingModel!.response!.news![index]),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: AppSize.s12,
                // ),
                // const OurLeadersOnBoardingView(),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManager.themeBlueColor,
            onPressed: () {
              showModalBottomSheet<void>(
                // context and builder are
                // required properties in this widget
                context: context,
                builder: (BuildContext context) {
                  // we set up a container inside which
                  // we create center column and display text

                  // Returning SizedBox instead of a Container
                  return SizedBox(
                    height: 150,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen(whatToScan: 'attendance'))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/images/news.png", height: 40.0),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: Text('Scan Attendance\n(स्क्यान उपस्थित)', style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Image.asset('assets/images/qr-code.png', height: 35.0),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/home.png", height: 25.0),
                          const SizedBox(height: 3.0),
                          Text("Home", style: TextStyle(
                              fontWeight: FontWeight.bold, color: Color.fromRGBO(99, 99, 99, 1)
                          )),
                          //const Padding(padding: EdgeInsets.all(10))
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                          if (AppJSON.logInfo.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MoreView()));
                          } else {
                            errorLongToast("Login is required (लगइन आवश्यक छ)");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          }
                        },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/resume.png", height: 25.0),
                          const SizedBox(height: 3.0),
                          Text("Profile", style: TextStyle(
                            fontWeight: FontWeight.bold, color: Color.fromRGBO(99, 99, 99, 1)
                          )),
                          //const Padding(padding: EdgeInsets.only(left: 10))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void searchNews(SearchLoaded state) {
    List<News>? news;
    news = widget.onBoardingModel!.response!.news!.where((newsModel) {

      String? title = newsModel.title!.toLowerCase();
      String? description = newsModel.description!.toLowerCase();
      String? searchValue = state.searchValue.toLowerCase();
      return title.contains(searchValue) || description.contains(searchValue);

    }).toList();
    _news = news;
  }
}
