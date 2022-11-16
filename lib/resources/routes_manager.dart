import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/core/widgets/cpn_us_web_view.dart';
import 'package:cpn_us/features/gallery/presentation/pages/gallery_view.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/image_single_display.dart';
import 'package:cpn_us/features/gallery/presentation/widgets/images_view.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/single_news_display.dart';
import 'package:cpn_us/features/splash/presentation/views/splash_view.dart';
import 'package:cpn_us/features/video/presentation/widgets/web_view_video.dart';
import 'package:cpn_us/landing/landing_view.dart';
import 'package:cpn_us/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String cpnUsWebView = '/cpnUsWebView';
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPassowordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
  static const String webViewVideo = '/webViewVideo';
  static const String images = '/images';
  static const String galleryView = '/galleryView';
  static const String imageSingleDisplay = 'imageSingleDisplay';
  static const String singleNewsDisplay = '/singleNewsDisplay';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.cpnUsWebView:
        List data = routeSettings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => CpnUsWebView(
                  url: data[0],
                  title: data[1],
                ));

      case Routes.galleryView:
        return MaterialPageRoute(
          builder: (_) => GalleryView(),
        );

      case Routes.imageSingleDisplay:
        List data = routeSettings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => ImageSingleDisplay(
            response: data[0],
            index: data[1],
          ),
        );

      case Routes.images:
        List data = routeSettings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ImagesView(
                  title: data[0],
                  id: data[1].toString(),
                ));

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const LandingView()
            //OnBoardingView()
            );

      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      
      case Routes.singleNewsDisplay:
       var responseModel;
      String? imageUrl;
      if(routeSettings.arguments is News){
        responseModel = routeSettings.arguments as News;
        imageUrl = ApiConstant.newsImageUrl;
      }else if(routeSettings.arguments is NoticeResponse){
        responseModel = routeSettings.arguments as NoticeResponse;
        imageUrl = ApiConstant.noticeImageUrl;
      }
      
        return MaterialPageRoute(builder: (_) =>  SingleNewsDisplay(response: responseModel,imageUrl: imageUrl!,));

      case Routes.webViewVideo:
        List data = routeSettings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => WebViewVideo(
                  url: data[0],
                  videoTitle: data[1],
                ));

      // case Routes.forgotPassowordRoute:
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case Routes.mainRoute:
      //   return MaterialPageRoute(builder: (_) => const MainView());
      // case Routes.storeDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
