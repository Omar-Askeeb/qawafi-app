import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/features/account/presentation/pages/account_page.dart';
import 'package:qawafi_app/features/auth/presentation/pages/sign_in.dart';
import 'package:qawafi_app/features/favorite/presentation/bloc/favorites_bloc.dart';
import 'package:qawafi_app/features/favorite/presentation/pages/favorites_page.dart';
import 'package:qawafi_app/features/home/presentation/pages/home_page.dart';
import 'package:qawafi_app/features/home/presentation/pages/home_page_v2.dart';
import 'package:qawafi_app/features/home/presentation/pages/libyan_name.dart';
import 'package:qawafi_app/features/poet/presentation/pages/poet_page.dart';

import '../../../features/reels/presentation/pages/reels_page.dart';
import '../../../features/webview/presentation/pages/auth_webview.dart';
import '../../utils/nav_index_singleton.dart';
import '../cubits/app_user/app_user_cubit.dart';
import '../widgets/navbar.dart';

class MyAppPage extends StatefulWidget {
  static const String routeName = '/MyApp';
  static route() => MaterialPageRoute(
        builder: (context) => const MyAppPage(),
        settings: const RouteSettings(name: routeName),
      );
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (_currentIndex != index) {
      setState(() {
        NavSingleton().intValue = index;
        _currentIndex = index;
      });
      if (index == 3) context.read<FavoritesBloc>().add(FavoriteFetchEvent());
    } else {
      // This will pop to the first route of the navigator
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    }
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (_currentIndex != 0) {
        // Switch to the first tab (home tab)
        setState(() {
          _currentIndex = 0;
        });
        return false;
      }
    }
    // Let system handle back button if it's the first route in the current tab
    return isFirstRouteInCurrentTab;
  }

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn =
        context.read<AppUserCubit>().state is AppUserLoggedIn;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            _buildOffstageNavigator(4),
          ],
        ),
        bottomNavigationBar:
            QawafiNavBar(_currentIndex, _onTap, isUserLoggedIn),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (index) {
                case 0:
                  return const HomePageV2();
                case 1:
                  return const PoetPage();
                case 2:
                  return ReelsPage(); // LibyanNamePlaceholder(title: 'مقاطع فيديو قصيرة',);
                case 3:
                  return context.read<AppUserCubit>().state is AppUserInitial
                      ? const FlutterWebView()
                      : const FavoritesPage();
                case 4:
                  return context.read<AppUserCubit>().state is AppUserInitial
                      ? const FlutterWebView()
                      : const AccountPage();
                default:
                  return Container();
              }
            },
            settings: RouteSettings(name: '/bottom_navigation/$index'),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostScreen()),
            );
          },
          child: Text('Go to Post'),
        ),
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite')),
      body: Center(child: Text('Favorite Screen')),
    );
  }
}

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post')),
      body: Center(child: Text('Post Screen')),
    );
  }
}
