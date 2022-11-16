import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:cpn_us/features/notices/presentation/widgets/notice_card.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoticesDisplay extends StatefulWidget {
  final NoticesModel? noticesModel;
  const NoticesDisplay({super.key, this.noticesModel});

  @override
  State<NoticesDisplay> createState() => _NoticesDisplayState();
}

class _NoticesDisplayState extends State<NoticesDisplay> {
  List<NoticeResponse>? _response;
  @override
  void initState() {
    super.initState();
    _response = widget.noticesModel!.response!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if(state is SearchLoaded){
          searchNotice(state);
        }else if(state is SearchInitial){
          _response = widget.noticesModel!.response!;
        }
      },
      builder: (context, state) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _response!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20, vertical: AppPadding.p12),
              child: GestureDetector(
                  onTap: () {
                    navigateTo(index);
                  },
                  child: NoticeCard(
                    response: _response!,
                    index: index,
                  )),
            );
          },
        );
      },
    );
  }

  void navigateTo(int index) {
    final NavigationHelper navigationHelper =
        sl<NavigationHelper>();
    navigationHelper.navigateTo(Routes.singleNewsDisplay,
        arguments: _response![index]);
  }
  
  void searchNotice(SearchLoaded state) {
    List<NoticeResponse>? noticeResponse =  widget.noticesModel!.
    response!.
    where((noticeModel) {
      
      String title = noticeModel.title!.toLowerCase();
      String description = noticeModel.description!.toLowerCase();
      String searchValue = state.searchValue.toLowerCase();
      return title.contains(searchValue) || description.contains(searchValue);

    }).toList();
    _response = noticeResponse;
  }
}
