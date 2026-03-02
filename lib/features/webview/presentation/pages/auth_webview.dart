import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/entities/user.dart';
import 'package:qawafi_app/features/webview/presentation/bloc/web_view_bloc_bloc.dart';
import 'package:qawafi_app/init_dependencies.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/common/pages/my_app_page.dart';
import '../../../../core/localStorage/loacal_storage.dart' as appStorage;
import '../../../../core/utils/navigator_key.dart';
import '../../../auth/data/models/auth_response.dart';

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

class FlutterWebView extends StatefulWidget {
  const FlutterWebView({Key? key}) : super(key: key);
  static const String routeName = 'WebViewAuth';
  static route() => MaterialPageRoute(
        builder: (context) => FlutterWebView(),
        settings: const RouteSettings(name: routeName),
      );
  @override
  State<FlutterWebView> createState() => _FlutterWebViewState();
}

class _FlutterWebViewState extends State<FlutterWebView> {
  late WebViewController webViewController;
  late AppUserCubit appUserCubit;
  late appStorage.LocalStorage localStorage;

  @override
  void initState() {
    super.initState();
    appUserCubit = serviceLocator();
    localStorage = serviceLocator();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "Flutter",
        onMessageReceived: (JavaScriptMessage message) async {
          log("------message received------");
          log(message.message);

          AuthResponseModel auth = AuthResponseModel.fromJson(json.decode(
            message.message,
          )['data']);
          await localStorage
              .storeAccessToken(auth.tokenResponse.accessToken);
          await localStorage
              .storeRefreshToken(auth.tokenResponse.refreshToken);
          await localStorage.storeUserData(
            {
              'name': auth.userInfo.userName,
              'phoneNumber': auth.userInfo.phoneNumber,
            }.toString(),
          );
          User user = User(
            id: auth.userInfo.userId,
            phoneNumber: auth.userInfo.phoneNumber,
            name: auth.userInfo.fullName,
            balance: auth.userInfo.balance,
            customerType: auth.userInfo.customerType,
            fullName: auth.userInfo.fullName,
            note: auth.userInfo.note,
          );
          appUserCubit.updateUser(user);
          localStorage.storeUser(jsonEncode(user.toJson()));

          navigatorKey.currentState!.pushAndRemoveUntil(
            MyAppPage.route(),
            (route) => false,
          );
          // Navigator.of(context).pop(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            log("------created------");
          },
        ),
      )
      ..loadRequest(Uri.parse("https://qawafi.com.ly/Login"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: webViewController),
    );
  }
}

class WebViewAuth extends StatefulWidget {
  const WebViewAuth({
    super.key,
  });

  static const String routeName = 'WebViewAuth';
  static route() => MaterialPageRoute(
        builder: (context) => WebViewAuth(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _WebViewAuthState createState() => _WebViewAuthState();
}

class _WebViewAuthState extends State<WebViewAuth> {
  inapp.InAppWebViewController? webViewController;

  late AppUserCubit appUserCubit;
  late appStorage.LocalStorage localStorage;

  @override
  void initState() {
    // TODO: implement initState
    appUserCubit = serviceLocator();
    localStorage = serviceLocator();

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
        body: inapp.InAppWebView(
          initialUrlRequest: inapp.URLRequest(
            url: inapp.WebUri(
                // "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}",
                "https://qawafi.com.ly/Login",
                forceToStringRawValue: true),

            // url: inapp.WebUri(
            //     "https://q-test-landing-page.azurewebsites.net/mobileview/${widget.costId}",
            //     forceToStringRawValue: true),
          ),

          initialSettings: InAppWebViewSettings(
            clearCache: true,
            clearSessionCache: true,
          ),
          // onReceivedServerTrustAuthRequest: (controller, challenge) async {
          //   print(challenge);
          //   return ServerTrustAuthResponse(
          //       action: ServerTrustAuthResponseAction.PROCEED);
          // },
          onLoadStart: (controller, url) async {
            String? x = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('evina_security');");

            log("evina_security 22: ${x ?? 'x'}");
          },
          onLoadStop: (controller, url) async {
            // Set up a handler for receiving messages from JavaScript
            controller.addJavaScriptHandler(
              handlerName:
                  'Flutter', // Handler name must match the JavaScript call
              callback: (args) {
                // This block will be executed when JavaScript sends data
                log("Received data from JavaScript: ${args[0]}");

                // Handle the data passed from JavaScript
                String dataReceived =
                    args[0]; // The 'data to pass' string from JS

                // You can process the data here, or perform actions based on it
                // For example, update state or send this data to another part of your app

                return {"status": "success", "receivedData": dataReceived};
              },
            );
            controller.addJavaScriptHandler(
                handlerName: 'tokenHandler',
                callback: (args) async {
                  log("Token Handler...................");
                  String? token = await controller.evaluateJavascript(
                      source: "window.localStorage.getItem('authToken');");
                  String? refresh = await controller.evaluateJavascript(
                      source: "window.localStorage.getItem('refreshToken');");

                  if (token != null && refresh != null) {
                    appUserCubit.updateUser(User(
                        fullName: '',
                        note: '',
                        balance: 0,
                        customerType: 'Subscribed',
                        id: 'id',
                        phoneNumber: 'phoneNumber',
                        name: ''));
                    await localStorage.storeAccessToken(token);
                    await localStorage.storeRefreshToken(refresh);
                    log("Received Token: ${token ?? 'No Token'}");
                    log("Received Refresh Token: ${refresh ?? 'No Refresh Token'}");
                    return {"status": "received"};
                  }
                });
            String? x = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('evina_security');");
            String? token = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('authToken');");
            String? refresh = await controller.evaluateJavascript(
                source: "window.localStorage.getItem('refreshToken');");
            if (token != null && refresh != null) {
              appUserCubit.updateUser(User(
                  fullName: '',
                  note: '',
                  balance: 0,
                  customerType: 'Subscribed',
                  id: 'id',
                  phoneNumber: 'phoneNumber',
                  name: ''));

              await localStorage.storeAccessToken(token);
              await localStorage.storeRefreshToken(refresh);

              navigatorKey.currentState!.pushAndRemoveUntil(
                MyAppPage.route(),
                (route) => false,
              );
            }

            // Remove the tokens from local storage
            await controller.evaluateJavascript(
                source: "window.localStorage.removeItem('authToken');");
            await controller.evaluateJavascript(
                source: "window.localStorage.removeItem('refreshToken');");

            log("evina_security : ${x ?? 'ss'}");
            log("token : ${token ?? 'ww'}");
            log("efresh : ${refresh ?? 'ZZ'}");
          },
          onWebViewCreated: (controller) {
            // Handle WebView creation here
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
            log('URL : XXX $url');
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
