import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

import 'sign_in.dart';
import 'sign_up.dart';

class TabViewWrapper extends StatefulWidget {
  static const String routeName = '/TabViewWrapper';
  static route(int index) => MaterialPageRoute(
        builder: (context) => TabViewWrapper(tabIndex: index),
        settings: const RouteSettings(name: routeName),
      );

  final int tabIndex;
  const TabViewWrapper({super.key, this.tabIndex = 0});

  @override
  State<TabViewWrapper> createState() => _TabViewWrapperState();
}

class _TabViewWrapperState extends State<TabViewWrapper>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
          title: _tabController!.index == 0 ? 'تسجيل الدخول' : 'حساب جديد',
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  onTap: (value) {
                    setState(() {});
                  },
                  splashBorderRadius: BorderRadius.circular(25),
                  controller: _tabController,
                  dividerColor: AppPallete.transparentColor,

                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: const Color(0xFFFFFFFF),
                  ),
                  // indicator: BoxDecoration(),
                  labelColor: const Color(0xFF10263D),
                  unselectedLabelStyle:
                      const TextStyle(fontFamily: 'Helvetica'),
                  indicatorSize: TabBarIndicatorSize.tab,

                  unselectedLabelColor:
                      const Color.fromARGB(255, 179, 179, 179),
                  tabs: const [
                    Tab(
                      text: 'تسجيل الدخول',
                    ),
                    Tab(
                      text: 'حساب جديد',
                    ),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SignIn(),
                    SignUp(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
