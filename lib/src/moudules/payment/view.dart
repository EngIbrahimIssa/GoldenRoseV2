import 'dart:async';
import 'dart:developer';
import 'dart:io';

import '../../binding.dart';
import '../../data/remote/api_requests.dart';
import '../../data/shared_preferences/pref_manger.dart';
import '../success_order/view.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../images.dart';

class PaymentScreen extends StatefulWidget {
  final String url;

  PaymentScreen({required this.url});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  ///
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        applePayAPIEnabled: true,
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  double progress = 0;
  String url ='';
  final urlController = TextEditingController();

  ///
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final PrefManger _prefManger = Get.find();
  final ApiRequests _apiRequests = Get.find();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //if (Platform.isAndroid) WebView.platform = AndroidWebView();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      isLoading = !isLoading;
      setState(() {});
    });
    url = widget.url;
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  Future<void> getSession() async {
    try {
      var response = await _apiRequests.createSession();
      var session = response.data['payload']['cart_session_id'];
      log("new session => $session");
      await _prefManger.setSession(session);
      await _apiRequests.onInit();
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Image.asset(iconLogoText, height: 40.h)),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest:
            URLRequest(url: Uri.parse(widget.url)),
            initialOptions: options,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url)async {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });

            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {

              var uri = navigationAction.request.url!;
              log('url => $uri');
              if (uri.toString().contains('order-completed')) {
                var orderId = uri.toString().substring(uri.toString().length - 18, uri.toString().length - 8);
                await getSession();
                Get.offAll(
                    SuccessOrderPage(
                      orderId: orderId,
                    ),
                    binding: Binding());
              }
              if (![ "http", "https", "file", "chrome",
                "data", "javascript", "about"].contains(uri.scheme)) {
                if (await canLaunch(url)) {
                  // Launch the App
                  await launch(
                    url,
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              pullToRefreshController.endRefreshing();
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onLoadError: (controller, url, code, message) {
              pullToRefreshController.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController.endRefreshing();
              }
              setState(() {
                this.progress = progress / 100;
                urlController.text = this.url;
              });
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(consoleMessage);
            },
          ),
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
/*          WebView(
            backgroundColor: Colors.white,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.disabled,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              setState(() {});
            },
            onProgress: (int webviewProgress) {
              log(webviewProgress.toString());
            },
            onPageStarted: (url) async {
              log('url => $url');
              if (url.contains('order-completed')) {
                var orderId = url.substring(url.length - 18, url.length - 8);
                await getSession();
                Get.offAll(
                    SuccessOrderPage(
                      orderId: orderId,
                    ),
                    binding: Binding());
              }
            },
          ),
          Visibility(
              visible: isLoading,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()))),*/
          Visibility(
              visible: isLoading,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()))),
        ],
      ),
    );
  }
}
