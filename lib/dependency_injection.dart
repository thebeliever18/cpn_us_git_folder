import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/helper/shared_preference_helper/shared_preference_helper.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/about_us/data/datasources/about_us_remote_data_source.dart';
import 'package:cpn_us/features/about_us/data/repositories/about_us_repository_impl.dart';
import 'package:cpn_us/features/about_us/domain/repositories/about_us_repository.dart';
import 'package:cpn_us/features/about_us/domain/usecases/get_about_us_data.dart';
import 'package:cpn_us/features/about_us/presentation/bloc/about_us_bloc.dart';
import 'package:cpn_us/features/committee/data/datasources/committee_remote_data_source.dart';
import 'package:cpn_us/features/committee/data/repositories/committee_repository_impl.dart';
import 'package:cpn_us/features/committee/domain/repositories/committee_repository.dart';
import 'package:cpn_us/features/committee/domain/usecases/get_committee_data.dart';
import 'package:cpn_us/features/committee/domain/usecases/get_committee_title.dart';
import 'package:cpn_us/features/committee/presentation/bloc/committee_bloc.dart';
import 'package:cpn_us/features/event/data/datasources/event_remote_data_source.dart';
import 'package:cpn_us/features/event/data/repositories/event_repository_impl.dart';
import 'package:cpn_us/features/event/domain/repositories/event_repository.dart';
import 'package:cpn_us/features/event/domain/usecases/get_download_data.dart';
import 'package:cpn_us/features/event/domain/usecases/get_event_data.dart';
import 'package:cpn_us/features/event/presentation/bloc/event_bloc.dart';
import 'package:cpn_us/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:cpn_us/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:cpn_us/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:cpn_us/features/gallery/domain/usecases/get_gallery_data.dart';
import 'package:cpn_us/features/gallery/domain/usecases/get_images_data.dart';
import 'package:cpn_us/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:cpn_us/features/notices/data/datasources/notices_remote_data_source.dart';
import 'package:cpn_us/features/notices/data/repositories/notices_repository_impl.dart';
import 'package:cpn_us/features/notices/domain/repositories/notices_repository.dart';
import 'package:cpn_us/features/notices/domain/usecases/get_notices_data.dart';
import 'package:cpn_us/features/notices/presentation/bloc/notices_bloc.dart';
import 'package:cpn_us/features/on_boarding/data/datasources/on_boarding_remote_data_source.dart';
import 'package:cpn_us/features/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:cpn_us/features/on_boarding/domain/usecases/get_on_boarding_data.dart';
import 'package:cpn_us/features/on_boarding/presentation/bloc/on_boarding_bloc.dart';
import 'package:cpn_us/features/our_leaders/data/datasources/our_leaders_remote_data_source.dart';
import 'package:cpn_us/features/our_leaders/data/repositories/our_leaders_repository_impl.dart';
import 'package:cpn_us/features/our_leaders/domain/repositories/our_leaders_repository.dart';
import 'package:cpn_us/features/our_leaders/domain/usecases/get_our_leaders_data.dart';
import 'package:cpn_us/features/our_leaders/presentation/bloc/our_leaders_bloc.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/features/video/data/datasources/video_remote_data_source.dart';
import 'package:cpn_us/features/video/data/repositories/video_repository_impl.dart';
import 'package:cpn_us/features/video/domain/repositories/video_repository.dart';
import 'package:cpn_us/features/video/domain/usecases/get_video_data.dart';
import 'package:cpn_us/features/video/presentation/bloc/video_bloc.dart';
import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/on_boarding/domain/repositories/on_boarding_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {

  ////features - Landing
  ///Bloc
  sl.registerFactory(() => LandingBloc());

  ////features - Search
  ///Bloc
  sl.registerFactory(() => SearchBloc());


  ////features - OnBoarding
  ///Bloc
  sl.registerFactory(() => OnBoardingBloc(getOnBoardingData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetOnBoardingData(sl()));

  ////repository
  sl.registerLazySingleton<OnBoardingRepository>(() =>
      OnBoardingRepoImpl(onBoardingRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<OnBoardingRemoteDataSource>(
      () => OnBoardingRemoteDataSourceImpl(dio: sl()));


  ////features - OurLeaders
  ///Bloc
  sl.registerFactory(() => OurLeadersBloc(getOurLeadersData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetOurLeadersData(sl()));

  ////repository
  sl.registerLazySingleton<OurLeadersRepository>(() =>
      OurLeadersRepoImpl(ourLeadersRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<OurLeadersRemoteDataSource>(
      () => OurLeadersRemoteDataSourceImpl(dio: sl()));


   ////features - AboutUs
  ///Bloc
  sl.registerFactory(() => AboutUsBloc(getAboutUsData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetAboutUsData(sl()));

  ////repository
  sl.registerLazySingleton<AboutUsRepository>(() =>
      AboutUsRepoImpl(aboutUsRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<AboutUsRemoteDataSource>(
      () => AboutUsRemoteDataSourceImpl(dio: sl()));


   ////features - Video
  ///Bloc
  sl.registerFactory(() => VideoBloc(getVideoData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetVideoData(sl()));

  ////repository
  sl.registerLazySingleton<VideoRepository>(() =>
      VideoRepoImpl(videoRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<VideoRemoteDataSource>(
      () => VideoRemoteDataSourceImpl(dio: sl()));



  ////features -Gallery
  ///Bloc
  sl.registerFactory(() =>GalleryBloc(getGalleryData: sl(),getImagesData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetGalleryData(sl()));
  sl.registerLazySingleton(() => GetImagesData(sl()));

  ////repository
  sl.registerLazySingleton<GalleryRepository>(() =>
     GalleryRepoImpl(galleryRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<GalleryRemoteDataSource>(
      () =>GalleryRemoteDataSourceImpl(dio: sl()));



 ////features -Event
  ///Bloc
  sl.registerFactory(() =>EventBloc(getEventData: sl(),getDownloadData:sl()));

  ////use cases
  sl.registerLazySingleton(() => GetEventData(sl()));
  sl.registerLazySingleton(() => GetDownloadData(sl()));
  ////repository
  sl.registerLazySingleton<EventRepository>(() =>
     EventRepoImpl(eventRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<EventRemoteDataSource>(
      () =>EventRemoteDataSourceImpl(dio: sl()));




   ////features -Notices
  ///Bloc
  sl.registerFactory(() =>NoticesBloc(getNoticesData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetNoticesData(sl()));

  ////repository
  sl.registerLazySingleton<NoticesRepository>(() =>
     NoticesRepoImpl(noticesRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<NoticesRemoteDataSource>(
      () =>NoticesRemoteDataSourceImpl(dio: sl()));



   ////features -Committee
  ///Bloc
  sl.registerFactory(() =>CommitteeBloc(getCommitteeData: sl(),getCommitteeTitleData: sl()));

  ////use cases
  sl.registerLazySingleton(() => GetCommitteeData(sl()));
  sl.registerLazySingleton(() => GetCommitteeTitleData(sl()));

  ////repository
  sl.registerLazySingleton<CommitteeRepository>(() =>
     CommitteeRepoImpl(committeeRemoteDataSource: sl(), networkInfo: sl()));

  ////datasources
  sl.registerLazySingleton<CommitteeRemoteDataSource>(
      () =>CommitteeRemoteDataSourceImpl(dio: sl()));












































  ////core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///Navigation service
  sl.registerLazySingleton<NavigationHelper>(() => NavigationHelper(navigatorKey: sl()));
  sl.registerLazySingleton<SharedPreferenceHelper>(()=>SharedPreferenceHelper(sharedPreferences: sl()));

  ////external
  final sharedPreferences = await SharedPreferences.getInstance();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  sl.registerLazySingleton(() => navigatorKey);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
