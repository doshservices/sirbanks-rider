import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sirbank_rider/model/card_model.dart';
import 'package:sirbank_rider/provider/auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddCardPayment extends StatefulWidget {
  // const AddCardPayment({ Key? key }) : super(key: key);

  @override
  _AddCardPaymentState createState() => _AddCardPaymentState();
}

class _AddCardPaymentState extends State<AddCardPayment> with SingleTickerProviderStateMixin{
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isPageLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as CardModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          "Make Payment",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return Stack(
            children: [
              WebView(
                initialUrl: "${arguments.authorizationUrl}",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>[
                  // _toasterJavascriptChannel(context),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) async {
                  print("//////" + url.toString());
                  // print(arguments.authorizationUrl);
                  setState(() {
                    _isPageLoading = false;
                  });
                  await Provider.of<Auth>(context, listen: false).completePayment(arguments.reference);
                  // Navigator.of(context).pop();
                },
                gestureNavigationEnabled: true,
              ),
              _isPageLoading
                  ? Center(
                      child: SpinKitWave(
                        color: Colors.black,
                        size: 50.0,
                        controller: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 1200)),
                      ),
                    )
                  : Text("")
            ],
          );
        }),
      ),
    );
  }
}
