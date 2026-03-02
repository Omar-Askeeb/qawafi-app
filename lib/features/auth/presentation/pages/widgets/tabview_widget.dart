// import 'package:flutter/material.dart';

// class TabViewWidget extends StatefulWidget {
//   const TabViewWidget({
//     super.key,
//     required this.tabController,
//   });
//   final TabController tabController;

//   @override
//   State<TabViewWidget> createState() => _TabViewWidgetState();
// }

// class _TabViewWidgetState extends State<TabViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(
//         horizontal: 15,
//       ),
//       height: 55,
//       decoration: BoxDecoration(
//         color: const Color(0xFFF7F8FA),
//         borderRadius: BorderRadius.circular(
//           25.0,
//         ),
//       ),
//       child: TabBar(

//         onTap: (value) {
//           print('tap');
//         },
//         splashBorderRadius: BorderRadius.circular(25),
//         controller: widget.tabController,

//         indicator: BoxDecoration(
//           borderRadius: BorderRadius.circular(
//             25.0,
//           ),
//           color: const Color(0xFFFFFFFF),
//         ),
//         // indicator: BoxDecoration(),
//         labelColor: const Color(0xFF10263D),
//         unselectedLabelStyle: const TextStyle(fontFamily: 'Helvetica'),
//         indicatorSize: TabBarIndicatorSize.tab,

//         unselectedLabelColor: const Color.fromARGB(255, 179, 179, 179),
//         tabs: const [
//           Tab(
//             text: 'تسجيل الدخول',
//           ),
//           Tab(
//             text: 'حساب جديد',
//           ),
//         ],
//       ),
//     );
//   }
// }
