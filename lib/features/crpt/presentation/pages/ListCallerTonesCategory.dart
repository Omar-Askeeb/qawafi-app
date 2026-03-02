import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/features/crpt/presentation/pages/ListMaleAndFemale.dart';

class CallerTonesCategoryPage extends StatefulWidget {
  static const String routeName = '/CallerTonesCategory';
  static route({required String writtenLetter}) => MaterialPageRoute(
        builder: (context) =>
            CallerTonesCategoryPage(writtenLetter: writtenLetter),
        settings: const RouteSettings(name: routeName),
      );
  const CallerTonesCategoryPage({required this.writtenLetter});
  final String writtenLetter;

  @override
  State<CallerTonesCategoryPage> createState() =>
      _CallerTonesCategoryPageState();
}

class _CallerTonesCategoryPageState extends State<CallerTonesCategoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
          title: " رنات بحرف  " + widget.writtenLetter,
        ),
        body: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Cairo'),
          child: Container(
            // color: Colors.black,
            child: Column(
              children: [
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAEDF2).withOpacity(0.1),
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
                      color: const Color(0xFFEAC578),
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
                        text: 'إنــــــاث',
                      ),
                      Tab(
                        text: 'ذكــــــور',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(
                          child: ListmaleAndfemale(
                        alpha: widget.writtenLetter,
                        gender: 'Female',
                      )),
                      Center(
                          child: ListmaleAndfemale(
                        alpha: widget.writtenLetter,
                        gender: 'Male',
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
