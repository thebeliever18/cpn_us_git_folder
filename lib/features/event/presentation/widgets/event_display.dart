
import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:cpn_us/features/event/presentation/widgets/event_card.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/values_manager.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDisplay extends StatefulWidget {
  final EventModel? eventModel;
  final DownloadModel? downloadModel;
  const EventDisplay({super.key, this.eventModel, this.downloadModel});

  @override
  State<EventDisplay> createState() => _EventDisplayState();
}

class _EventDisplayState extends State<EventDisplay> {
  List<EventResponse>? _response;
  @override
  void initState() {
    super.initState();
    _response = widget.eventModel!.response!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if(state is SearchLoaded){
            searchEvent(state);
        }else if(state is SearchInitial){
          _response = widget.eventModel!.response!;
        }
      },
      builder: (context, state) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
          ),
          itemCount: _response!.length,
          itemBuilder: (context, index) {
            return EventCard(
              title: _response![index].title!,
              description: _response![index].description!,
              date: _response![index].eventdate!,
              file: _response![index].file,
            );
          },
        );
      },
    );
  }
  
  void searchEvent(SearchLoaded state) {
    List<EventResponse>? response = widget.eventModel!.response!.where((eventModel) {

      String title = eventModel.title!.toLowerCase();
      String description = eventModel.description!.toLowerCase();
      String date = eventModel.eventdate!.toLowerCase();
      String searchValue = state.searchValue.toLowerCase();
      return title.contains(searchValue) || description.contains(searchValue) || date.contains(searchValue);
    }).toList();

    _response = response;
  }
}
