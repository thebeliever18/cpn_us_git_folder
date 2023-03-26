import 'dart:developer';
import 'dart:io';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/cpn_us_app_bar.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CpnUsWebView extends StatefulWidget {
  final String url;
  final String title;
  const CpnUsWebView({super.key, required this.url, required this.title});

  @override
  State<CpnUsWebView> createState() => _CpnUsWebViewState();
}

class _CpnUsWebViewState extends State<CpnUsWebView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CpnUsAppBar(
        goBack: true,
        appBarCustomTitle:widget.title,
        onTap: (){
             final NavigationHelper navigationHelper = sl<NavigationHelper>();
              navigationHelper.pop();
          },),
        body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              
              initialUrl: widget.url,
              onPageStarted: (a) {
                
              },
              onProgress: (a) {
                log(a.toString());
              },
              onWebViewCreated: (a){
                
              },
              onPageFinished: (a) {
                setState(() {
                  isLoading=false;
                });
              },
            ),
            isLoading?LinearProgressIndicator():Stack()
          ],
        ),
      ),
    );
  }
}
