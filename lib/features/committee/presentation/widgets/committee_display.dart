import 'dart:developer';
import 'package:cpn_us/core/widgets/cpn_us_tab_bar.dart';
import 'package:cpn_us/core/widgets/cpn_us_tab_bar_container.dart';
import 'package:cpn_us/features/committee/data/models/committee_model.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:cpn_us/features/committee/presentation/bloc/committee_bloc.dart';
import 'package:cpn_us/features/committee/presentation/widgets/committee_member_card.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class CommitteeDisplay extends StatefulWidget {
  final CommitteeTitleModel? committeeTitleModel;
  final CommitteeModel? committeeModel;
  const CommitteeDisplay(
      {super.key, this.committeeTitleModel, this.committeeModel});

  @override
  State<CommitteeDisplay> createState() => _CommitteeDisplayState();
}

class _CommitteeDisplayState extends State<CommitteeDisplay>
    with TickerProviderStateMixin {
  List<CommitteeTitleResponse>? _committeeTitleResponse;
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _committeeTitleResponse = widget.committeeTitleModel!.response!;
    _controller =
        TabController(length: _committeeTitleResponse!.length, vsync: this);
    getCommitteeData(index: 0);
    _controller!.addListener(() {
      log(_controller!.index.toString());
      getCommitteeData(index: _controller!.index);
    });
  }

  @override
  void didUpdateWidget(covariant CommitteeDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('widget updated');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoaded) {
          searchCommittee(state);
          _controller = TabController(
              length: _committeeTitleResponse!.length, vsync: this);
          if (state.searchValue != "") {
            getCommitteeData(index: _controller!.index);
          }

          _controller!.addListener(() {
            log(_controller!.index.toString());
            getCommitteeData(index: _controller!.index);
          });
        } else if (state is SearchInitial) {
          _committeeTitleResponse = widget.committeeTitleModel!.response!;
          _controller = TabController(
              length: _committeeTitleResponse!.length, vsync: this);
          if (state.searchValue != "") {
            getCommitteeData(index: _controller!.index);
          }
          _controller!.addListener(() {
            log(_controller!.index.toString());
            getCommitteeData(index: _controller!.index);
          });
        }
      },
      builder: (context, state) {
        return CpnUsTabBar(
          length: _committeeTitleResponse!.length,
          controller: _controller,
          tabs: List.generate(
            _committeeTitleResponse!.length,
            ((index) => CpnUsTabBarContainer(
                title: _committeeTitleResponse![index].title!)),
          ),
          children: List.generate(
            _committeeTitleResponse!.length,
            ((index) => widget.committeeModel == null
                ? Center(child: CircularProgressIndicator())
                : widget.committeeModel!.response!.isEmpty
                    ? Center(child: Text('No data in this committee'))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppSize.s4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p24),
                            child: Wrap(children: [
                              Text(
                                parse(_committeeTitleResponse![index]
                                            .description ??
                                        '')
                                    .body!
                                    .text,
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.justify,
                              )
                            ]),
                          ),
                          Expanded(
                            flex: 12,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.committeeModel!.response!.length,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, ind) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p20,
                                    vertical: AppPadding.p12),
                                child: SizedBox(
                                  height: AppSize.s70,
                                  width: size.width,
                                  child: InkWell(
                                      onTap: () async {
                                        await launchUrl(Uri(
                                          scheme: 'tel',
                                          path: widget.committeeModel!
                                              .response![ind].mobilenumber,
                                        ));
                                      },
                                      child: widget.committeeModel == null
                                          ? ind == 0
                                              ? Text('')
                                              : null
                                          : CommitteeMemberCard(
                                              widget: widget, ind: ind)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
          ),
        );
      },
    );
  }

  void getCommitteeData({required int index}) {
    if(_committeeTitleResponse!.isNotEmpty){
       BlocProvider.of<CommitteeBloc>(context).add(TriggerCommitteePostApi(
        committeeModel: CommitteeModel(response: [
      CommitteeModelResponse(
          cdetailsid: _committeeTitleResponse![index].ctitleid)
    ])));
    }
   
  }

  void searchCommittee(SearchLoaded state) {
    List<CommitteeTitleResponse>? committeeTitleResponse =
        widget.committeeTitleModel!.response!.where((committeeTitleModel) {
      String? committeeTitle = committeeTitleModel.title!.toLowerCase();
      String? committeeDescription =
          committeeTitleModel.description ?? ''.toLowerCase();

      String searchValue = state.searchValue;

      return committeeTitle.contains(searchValue) ||
          committeeDescription.contains(searchValue);
    }).toList();
    _committeeTitleResponse = committeeTitleResponse;
  }
}
