import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qawafi_app/features/webview/presentation/bloc/web_view_bloc_bloc.dart';

class WebViewChargeWallet extends StatefulWidget {
  static const String routeName = 'WebView';

  const WebViewChargeWallet(
      {super.key, required this.customerId, required this.token});

  static route({
    required token,
    required customerId,
  }) =>
      MaterialPageRoute(
        builder: (context) =>
            WebViewChargeWallet(customerId: customerId, token: token),
        settings: const RouteSettings(name: routeName),
      );

  final String customerId;
  final String token;

  @override
  _WebViewChargeWalletState createState() => _WebViewChargeWalletState();
}

class _WebViewChargeWalletState extends State<WebViewChargeWallet> {
  inapp.InAppWebViewController? webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Perform any necessary cleanup before the widget is disposed

    webViewController?.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    context.read<WebViewBlocBloc>().add(WebViewBlocSubDoneEvent(message: ""));
    return true;
  }

  final String baseUrl = 'https://qawafi.com.ly:5006';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text("منصة قوافي")),
        body: inapp.InAppWebView(
          initialUrlRequest: inapp.URLRequest(
            url: inapp.WebUri(
                // "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}",
                "$baseUrl/topup",
                forceToStringRawValue: true),
            // url: inapp.WebUri(
            //     "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}",
            //     forceToStringRawValue: true),
          ),
          initialSettings: InAppWebViewSettings(
              clearCache: true, cacheMode: CacheMode.LOAD_NO_CACHE),
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            print(challenge);
            return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
          },
          onLoadStart: (controller, url) async {
            var x = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('bearerToken');");
            log("xXXXX :$x");
            controller.evaluateJavascript(
                source:
                    "window.localStorage.setItem('bearerToken', '${widget.token}');");
            controller.evaluateJavascript(
                source:
                    "window.localStorage.setItem('CustomerId', '${widget.customerId}');");
            x = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('bearerToken');");
            log("xXXXX2 :$x");
          },
          onLoadStop: (controller, url) {},
          onWebViewCreated: (controller) {
            // Handle WebView creation here
            controller.evaluateJavascript(
                source:
                    "window.localStorage.setItem('bearerToken', '${widget.token}');");
            controller.evaluateJavascript(
                source:
                    "window.localStorage.setItem('CustomerId', '${widget.customerId}');");
            controller.addJavaScriptHandler(
              handlerName: "FlutterLog",
              callback: (args) {
                // Handle the data sent from JavaScript
                log("Message from WebView: ${args[0]}");
                return null;
              },
            );
          },
          onReceivedHttpError: (controller, request, errorResponse) {
            log("errorResponse.statusCode " +
                errorResponse.statusCode.toString());
            log("errorResponse.headers " + request.headers.toString());
            log("errorResponse.statusCode" +
                request.url.path +
                " - " +
                request.url.host.toString());
            log("errorResponse.contentEncoding. " +
                errorResponse.contentEncoding.toString());
            log("errorResponse.reasonPhrase " +
                '${errorResponse.data != null ? utf8.decode(errorResponse.data!) : "NO INFO"}');
          },
          onLoadError: (controller, url, code, message) {
            log("Error2: $message - $code");
          },
        ),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();

//   static const String routeName = 'WebView';

//   const MyApp({super.key, required this.costId, required this.token});

//   static route({
//     required token,
//     required costId,
//   }) =>
//       MaterialPageRoute(
//         builder: (context) => MyApp(costId: costId, token: token),
//         settings: const RouteSettings(name: routeName),
//       );

//   final costId;
//   final String token;
// }

// class _MyAppState extends State<MyApp> {
//   late inapp.InAppWebViewController _webViewController;
//   String url = "";
//   double progress = 0;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('InAppWebView Example'),
//         ),
//         body: Container(
//             child: Column(children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(20.0),
//             child: Text(
//                 "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
//           ),
//           Container(
//               padding: EdgeInsets.all(10.0),
//               child: progress < 1.0
//                   ? LinearProgressIndicator(value: progress)
//                   : Container()),
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.all(10.0),
//               decoration:
//                   BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//               child: inapp.InAppWebView(
//                 initialUrlRequest: inapp.URLRequest(
//                     url: inapp.WebUri(
//                         "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}")),
//                 initialOptions: inapp.InAppWebViewGroupOptions(
//                     crossPlatform: inapp.InAppWebViewOptions()),
//                 onWebViewCreated: (inapp.InAppWebViewController controller) {
//                   _webViewController = controller;
//                 },
//                 onProgressChanged:
//                     (inapp.InAppWebViewController controller, int progress) {
//                   setState(() {
//                     this.progress = progress / 100;
//                   });
//                 },
//               ),
//             ),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton(
//                 child: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   if (_webViewController != null) {
//                     _webViewController.goBack();
//                   }
//                 },
//               ),
//               TextButton(
//                 child: Icon(Icons.arrow_forward),
//                 onPressed: () {
//                   if (_webViewController != null) {
//                     _webViewController.goForward();
//                   }
//                 },
//               ),
//               TextButton(
//                 child: Icon(Icons.refresh),
//                 onPressed: () {
//                   if (_webViewController != null) {
//                     _webViewController.reload();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ])),
//       ),
//     );
//   }
// }
