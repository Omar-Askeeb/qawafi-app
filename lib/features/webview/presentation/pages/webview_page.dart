import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qawafi_app/features/webview/presentation/bloc/web_view_bloc_bloc.dart';

import '../../../../core/api/end_points.dart';

// class WebViewPage extends StatefulWidget {
//   static const String routeName = 'WebView';

//   static route({
//     required token,
//     required costId,
//   }) =>
//       MaterialPageRoute(
//         builder: (context) => WebViewPage(costId: costId, token: token),
//         settings: const RouteSettings(name: routeName),
//       );

//   final String token;
//   final costId;

//   WebViewPage({
//     required this.token,
//     required this.costId,
//   });

//   @override
//   _WebViewPageState createState() => _WebViewPageState();
// }

// class _WebViewPageState extends State<WebViewPage> {
//   WebViewController webView = WebViewController();

//   @override
//   void initState() {
//     super.initState();
//     _initializeWebView();
//     // _launchURL();
//     // testFunction();
//   }

//   void _launchURL() async {
//     const url = 'https://q-test-landing-page.azurewebsites.net';
//     await launch(url);
//   }

//   void testFunction() {
//     // #docregion platform_features

//     final WebViewController controller = WebViewController();
//     // #enddocregion platform_features

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       // ..setUserAgent(
//       //   "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
//       // )
//       ..clearCache()
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//           onHttpError: (HttpResponseError error) {
//             debugPrint('Error occurred on page: ${error.response?.statusCode}');
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//           onHttpAuthRequest: (HttpAuthRequest request) {},
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse(
//           "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}"));
//     setState(() {});
//   }

//   Future<String> localLoader() async {
//     return await rootBundle.loadString('assets/index.html');
//   }

//   Future<void> _initializeWebView() async {
//     webView = await WebViewController();

//     // Inject the token into localStorage
//     await webView.setJavaScriptMode(JavaScriptMode.unrestricted);

//     // await webView
//     //     .runJavaScript("localStorage.setItem('authToken', '${widget.token}');");
//     String url =
//         "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}";
//     // Load your desired URL
//     await webView.loadRequest(Uri.parse(url));
//     // await webView.loadHtmlString(await localLoader());

//     await webView.setNavigationDelegate(
//       NavigationDelegate(
//         onPageFinished: (url) async {
//           log('End loading page');
//           webView.runJavaScript(
//             "window.localStorage.setItem('authToken', '${widget.token}');",
//           );

//           var token2 = await webView.runJavaScriptReturningResult(
//               "window.localStorage.getItem('authToken');");

//           log("TOKEN ::::::: " + token2.toString());

//           // Get the HTML content of the web page
//           // var htmlContent = await webView.runJavaScriptReturningResult(
//           //     "document.documentElement.outerHTML;");

//           // log('HTML Content: $htmlContent');

//           await webView.addJavaScriptChannel("FlutterLog",
//               onMessageReceived: (JavaScriptMessage message) =>
//                   log("WebLog : $message"));
//         },
//       ),
//     );

//     // Retrieve the token from localStorage

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('WebView')),
//       body: WebViewWidget(controller: webView),
//     );
//   }
// }

class WebViewExample extends StatefulWidget {
  static const String routeName = 'WebView';

  const WebViewExample({super.key, required this.costId, required this.token});

  static route({
    required token,
    required costId,
  }) =>
      MaterialPageRoute(
        builder: (context) => WebViewExample(costId: costId, token: token),
        settings: const RouteSettings(name: routeName),
      );

  final costId;
  final String token;

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
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
                "${EndPoints.webViewbaseUrl}/mobileview/${widget.costId}",
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
                source: "window.localStorage.getItem('authToken');");
            log("xXXXX :$x");
            controller.evaluateJavascript(
                source:
                    "window.localStorage.setItem('authToken', '${widget.token}');");
            x = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('authToken');");
            log("xXXXX2 :$x");
          },
          onLoadStop: (controller, url) {},
          onWebViewCreated: (controller) {
            // Handle WebView creation here
            controller.evaluateJavascript(
                source:
                    "window.localStorage.setItem('authToken', '${widget.token}');");
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
