
import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:cpn_us/features/our_leaders/presentation/widgets/our_leaders_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/our_leaders_bloc.dart';




class OurLeadersView extends StatefulWidget {
  const OurLeadersView({Key? key}) : super(key: key);

  @override
  State<OurLeadersView> createState() => _OurLeadersViewState();
}

class _OurLeadersViewState extends State<OurLeadersView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<OurLeadersBloc>(context).add(TriggerOurLeadersPostApi(ourLeadersModel: OurLeadersModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OurLeadersBloc, OurLeadersState>(
      builder: (c, state) {
      if (state is OurLeadersLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Center(child: CircularProgressIndicator()),
          ],
        );
      }else if(state is OurLeadersLoaded){
        return OurLeadersDisplay(ourLeadersModel: state.ourLeadersModel,);
      }else if(state is OurLeadersNotLoaded){
        return CpnUsMessageDisplay(message: state.message);
      }return const Center(child: CircularProgressIndicator());
    });
  }
}
