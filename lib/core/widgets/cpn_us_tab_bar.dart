import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CpnUsTabBar extends StatelessWidget {
  final int length;
  final List<Widget> tabs;
  final List<Widget> children;
  final void Function(int)? onTap;
  final TabController? controller;
  const CpnUsTabBar(
      {Key? key,
      required this.length,
      required this.tabs,
      required this.children,
      this.onTap,
      required this.controller
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: length,
      child: Column(
        children: [
          Container(
            height: AppSize.s30,
            child: TabBar(
              physics: BouncingScrollPhysics(),
              isScrollable: true,
              splashFactory: NoSplash.splashFactory,
              
              controller: controller,
              onTap: onTap,
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              }),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 0.0,
              indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSize.s20)),
              tabs: tabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
                physics: BouncingScrollPhysics(), children: children),
          )
        ],
      ),
    );
  }
}
