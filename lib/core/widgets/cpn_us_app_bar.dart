import 'package:cpn_us/core/widgets/cpn_us_search_text_feild.dart';
import 'package:cpn_us/features/search/bloc/search_bloc.dart';
import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CpnUsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CpnUsAppBar(
      {Key? key,
      this.scaffoldKey,
      this.goBack = false,
      this.appBarCustomTitle,
      this.onTap,
      this.needSearch = true
      })
      : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool goBack;
  final String? appBarCustomTitle;
  final void Function()? onTap;
  final bool needSearch;

  @override
  State<CpnUsAppBar> createState() => _CpnUsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CpnUsAppBarState extends State<CpnUsAppBar> {
  TextEditingController? textEditingController;
  bool onSearchPressed = false;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        if (state is LandingIndexChanged) {
          return AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorManager.primary,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            title: onSearchPressed
                ? SizedBox(
                  child: CpnUsSearchTextFeild(
                  textEditingController: textEditingController,
                  onChanged: (value) {
                    BlocProvider.of<SearchBloc>(context).add(OnSearch(searchValue: value));
                  },
                  onTap: () {
                    setState(() {
                      onSearchPressed = !onSearchPressed;
                    });
                    BlocProvider.of<SearchBloc>(context).add(OnSearchClose(searchValue: textEditingController!.text));
                    textEditingController!.clear();

                  },),)
                : Text(
                    widget.goBack
                        ? widget.appBarCustomTitle!
                        : state.appBarTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
            centerTitle: false,
            elevation: 0,
            leading: widget.goBack
                ? InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorManager.darkGrey,
                    ),
                    onTap: widget.onTap)
                : InkWell(
                    child: Icon(
                      Icons.sort,
                      color: ColorManager.darkGrey,
                    ),
                    onTap: () {
                      widget.scaffoldKey!.currentState!.openDrawer();
                    },
                  ),
            actions: widget.goBack
                ? null
                : onSearchPressed
                    ? null 
                    : widget.needSearch? [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                onSearchPressed = !onSearchPressed;
                              });
                              BlocProvider.of<SearchBloc>(context).add(OnSearch());
                            },
                            icon: Icon(
                              Icons.search,
                              color: ColorManager.darkGrey,
                            ),),
                        // SizedBox(
                        //   width: AppSize.s16,
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.manage_accounts_outlined,
                        //       color: ColorManager.darkGrey,
                        //     ),
                        //     SizedBox(
                        //       width: AppSize.s8,
                        //     ),
                        //     Text(
                        //       'My Profile',
                        //       style: Theme.of(context).textTheme.labelMedium,
                        //     ),
                        //     SizedBox(
                        //       width: AppSize.s8,
                        //     )
                        //   ],
                        // ),
                        SizedBox(
                          width: AppSize.s14,
                        ),
                      ]:null
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
