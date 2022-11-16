import 'package:cpn_us/core/constants/api_constant.dart';
import 'package:cpn_us/features/on_boarding/presentation/widgets/leader_display_card.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OurLeadersDisplay extends StatefulWidget {
  final OurLeadersModel? ourLeadersModel;
  const OurLeadersDisplay({super.key, this.ourLeadersModel});

  @override
  State<OurLeadersDisplay> createState() => _OurLeadersDisplayState();
}

class _OurLeadersDisplayState extends State<OurLeadersDisplay> {
  List<LeaderResponse>? _leaderResponse;

  @override
  void initState() {
    super.initState();
    _leaderResponse = widget.ourLeadersModel!.response!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoaded) {
          searchLeader(state);
        } else if (state is SearchInitial) {
          _leaderResponse = widget.ourLeadersModel!.response!;
        }
      },
      builder: (context, state) {
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (200 / 230),
          ),
          itemCount: _leaderResponse!.length,
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p12,
                vertical: AppPadding.p12,
              ),
              child: LeaderDisplayCard(
                image: ApiConstant.ourleaderImageUrl +
                    _leaderResponse![index].image!,
                position: _leaderResponse![index].position!,
                name: _leaderResponse![index].name!,
              ),
            );
          },
        );
      },
    );
  }

  void searchLeader(SearchLoaded state) {
    List<LeaderResponse>? leaderResponse =
        widget.ourLeadersModel!.response!.where((leaderModel) {
      String name = leaderModel.name!.toLowerCase();
      String position = leaderModel.position!.toLowerCase();
      String searchValue = state.searchValue.toLowerCase();
      return name.contains(searchValue) ||
          position.contains(searchValue);
    }).toList();
    _leaderResponse = leaderResponse;
  }
}
