import 'package:cpn_us/core/widgets/cpn_us_message_display.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:cpn_us/features/committee/presentation/bloc/committee_bloc.dart';
import 'package:cpn_us/features/committee/presentation/widgets/committee_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommitteeView extends StatefulWidget {
  const CommitteeView({Key? key}) : super(key: key);

  @override
  State<CommitteeView> createState() => _CommitteeViewState();
}

class _CommitteeViewState extends State<CommitteeView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CommitteeBloc>(context).add(GetCommitteeTitle(committeeTitleModel: CommitteeTitleModel()));
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommitteeBloc, CommitteeState>(
      builder: (c, state) {
      if (state is CommitteeTitleLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Center(child: CircularProgressIndicator()),
          ],
        );
      }else if(state is CommitteeLoading){
        return CommitteeDisplay(committeeTitleModel: state.committeeTitleModel,);
      }else if(state is CommitteeLoaded){
        return CommitteeDisplay(committeeTitleModel: state.committeeTitleModel,
                committeeModel:state.committeeModel
        );
      }
      else if(state is CommitteeTitleLoaded){
        return CommitteeDisplay(committeeTitleModel: state.committeeTitleModel,);
      }else if(state is CommitteeTitleNotLoaded){
        return CpnUsMessageDisplay(message: state.message);
      }return const Center(child: CircularProgressIndicator());
    });
  }
}
