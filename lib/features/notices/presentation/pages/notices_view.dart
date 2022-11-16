import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:cpn_us/features/notices/presentation/bloc/notices_bloc.dart';
import 'package:cpn_us/features/notices/presentation/widgets/notices_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class NoticesView extends StatefulWidget {
  const NoticesView({Key? key}) : super(key: key);

  @override
  State<NoticesView> createState() => _NoticesViewState();
}

class _NoticesViewState extends State<NoticesView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<NoticesBloc>(context).add(TriggerNoticesPostApi(noticesModel: NoticesModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoticesBloc, NoticesState>(
      builder: (c, state) {
      if (state is NoticesLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Center(child: CircularProgressIndicator()),
          ],
        );
      }else if(state is NoticesLoaded){
        return NoticesDisplay(noticesModel:state.noticesModel);
      }else if(state is NoticesNotLoaded){
        return CpnUsMessageDisplay(message: state.message);
      }return const Center(child: CircularProgressIndicator());
    });
  }
}
