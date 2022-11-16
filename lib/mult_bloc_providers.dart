// ignore: implementation_imports
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/about_us/presentation/bloc/about_us_bloc.dart';
import 'package:cpn_us/features/committee/presentation/bloc/committee_bloc.dart';
import 'package:cpn_us/features/event/presentation/bloc/event_bloc.dart';
import 'package:cpn_us/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:cpn_us/features/notices/presentation/bloc/notices_bloc.dart';
import 'package:cpn_us/features/on_boarding/presentation/bloc/on_boarding_bloc.dart';
import 'package:cpn_us/features/our_leaders/presentation/bloc/our_leaders_bloc.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/features/video/presentation/bloc/video_bloc.dart';
import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

class MultiBlocProviders {
  static List<BlocProviderSingleChildWidget> blocProviders = [
    BlocProvider<LandingBloc>(
        create: (BuildContext context) => sl<LandingBloc>()),
    BlocProvider<OnBoardingBloc>(
        create: (BuildContext context) => sl<OnBoardingBloc>()),
    BlocProvider<OurLeadersBloc>(
        create: (BuildContext context) => sl<OurLeadersBloc>()),
    BlocProvider<AboutUsBloc>(
        create: (BuildContext context) => sl<AboutUsBloc>()),
    BlocProvider<VideoBloc>(create: (BuildContext context) => sl<VideoBloc>()),
    BlocProvider<GalleryBloc>(create: (BuildContext context) => sl<GalleryBloc>()),
    BlocProvider<EventBloc>(create: (BuildContext context) => sl<EventBloc>()),
    BlocProvider<NoticesBloc>(create: (BuildContext context) => sl<NoticesBloc>()),
    BlocProvider<CommitteeBloc>(create: (BuildContext context) => sl<CommitteeBloc>()),
    BlocProvider<SearchBloc>(create: (BuildContext context) => sl<SearchBloc>()),
  ];
}
