import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/constants/constants.dart';
import 'package:qawafi_app/features/popularProverbs/presentation/pages/ProverbsPage.dart';
//import 'package:testapp/ProverbsPage.dart';

class AlphabetPage extends StatelessWidget {
  const AlphabetPage();
  static const String routeName = '/Alphabet';
  static route() => MaterialPageRoute(
        builder: (context) => const AlphabetPage(),
        settings: const RouteSettings(name: routeName),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60.0), // زيادة ارتفاع الـ AppBar
      //   child: AppBar(
      //     leading: Padding(
      //       padding: const EdgeInsets.all(0),
      //       child: Transform.scale(
      //         scale: 1.5, // تغيير نسبة التكبير
      //         child: Image.asset('assets/logo.png'), // شعار التطبيق
      //       ),
      //     ),
      //     title: Center(
      //       child: Text(
      //         'الأمثال الشعبية',
      //         style: TextStyle(
      //           color: Color.fromRGBO(233, 195, 120, 1),
      //           fontSize: 30,
      //         ),
      //       ),
      //     ),
      //     backgroundColor: Colors.black,
      //     actions: [
      //       IconButton(
      //         icon: Icon(Icons.arrow_forward),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      appBar: QawafiAppBar(
        title: 'الأمثال الشعبية',
      ),
      body: Column(
        children: [
          Container(
            height: 10, // يمكنك تعديل الارتفاع حسب الحاجة
            color: Colors.black, // الخلفية الشفافة
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                "قم بالضغط على الحرف الذي تبدأ به الأمثال \n التي تبحث عنها",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: 1.0,
                ),
                itemCount:
                    Constants.arabicAlphabet.length, // عدد الحروف الأبجدية
                itemBuilder: (context, index) {
                  // تحويل رقم الاندكس إلى حرف باللغة العربية
                  String letter =
                      Constants.arabicAlphabet.keys.elementAt(index);
                  String WrittenLetter =
                      Constants.arabicAlphabet.values.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProverbsPage(writtenLetter: WrittenLetter),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(76, 64, 40, 1), // لون الزر
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        letter,
                        style: TextStyle(
                          color: Colors.white, // لون النص
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
