import 'package:cpn_us/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CpnUsSearchTextFeild extends StatelessWidget {
  final TextEditingController? textEditingController;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CpnUsSearchTextFeild(
      {
        super.key, 
          this.textEditingController, 
          this.onTap,
          this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: ColorManager.drakBlue,
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: 'Search here',
          suffixIcon: InkWell(onTap: onTap, child: Icon(Icons.close))
          ),
    );
  }
}
