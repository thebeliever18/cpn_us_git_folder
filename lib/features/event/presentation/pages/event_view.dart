import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:cpn_us/features/event/presentation/bloc/event_bloc.dart';
import 'package:cpn_us/features/event/presentation/widgets/event_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class EventView extends StatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<EventBloc>(context).add(TriggerEventPostApi(eventModel: EventModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (c, state) {
      if (state is EventLoading) {
      //BlocProvider.of<EventBloc>(context).add(TriggerEventPostApi(eventModel: EventModel()));

        // BlocProvider.of<LandingBloc>(context)
        //           .add(OnDrawerItemClicked(index: 3,activate: true,appBarTitle: AppStrings.events));
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Center(child: CircularProgressIndicator()),
          ],
        );
      }else if(state is DownloadDataLoading){
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(state.downloadModel.downloadFileName!,style: Theme.of(context).textTheme.headline1,),
            Text('This file is being downloaded. Please wait',style: Theme.of(context).textTheme.headline1,),
            Center(child: CircularProgressIndicator()),
          ],
        );
      }
      else if(state is EventLoaded){
        return EventDisplay(eventModel: state.eventModel,);
      }else if(state is EventNotLoaded){
        return CpnUsMessageDisplay(message: state.message);
      }return const Center(child: CircularProgressIndicator());
    });
  }
}
