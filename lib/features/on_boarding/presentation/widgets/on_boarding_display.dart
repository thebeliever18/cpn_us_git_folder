import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/news_display.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/our_leaders_onboarding_view.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/strings_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingDisplay extends StatefulWidget {
  final OnBoardingModel? onBoardingModel;
  const OnBoardingDisplay({super.key, this.onBoardingModel});

  @override
  State<OnBoardingDisplay> createState() => _OnBoardingDisplayState();
}

class _OnBoardingDisplayState extends State<OnBoardingDisplay> {
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
        return ListView(
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
            SizedBox(
              height: AppSize.s12,
            ),
            const OurLeadersOnBoardingView(),
          ],
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
