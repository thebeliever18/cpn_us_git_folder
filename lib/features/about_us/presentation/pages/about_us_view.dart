import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:cpn_us/features/about_us/presentation/bloc/about_us_bloc.dart';
import 'package:cpn_us/features/about_us/presentation/widgets/about_us_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AboutUsBloc>(context).add(TriggerAboutUsPostApi(aboutUsModel: AboutUsModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutUsBloc, AboutUsState>(
      builder: (c, state) {
      if (state is AboutUsLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Center(child: CircularProgressIndicator()),
          ],
        );
      }else if(state is AboutUsLoaded){
        return AboutUsDisplay(aboutUsModel: state.aboutUsModel,);
      }else if(state is AboutUsNotLoaded){
        return CpnUsMessageDisplay(message: state.message);
      }return const Center(child: CircularProgressIndicator());
    });
  }
}
