import 'dart:developer';
import 'dart:io';

import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/core/widgets/cpn_us_app_bar.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewVideo extends StatefulWidget {
  final String url;
  final String videoTitle;
  const WebViewVideo({super.key, required this.url, required this.videoTitle});

  @override
  State<WebViewVideo> createState() => _WebViewVideoState();
}

class _WebViewVideoState extends State<WebViewVideo> {
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
        appBar: CpnUsAppBar(goBack: true,appBarCustomTitle:widget.videoTitle,onTap: (){
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
