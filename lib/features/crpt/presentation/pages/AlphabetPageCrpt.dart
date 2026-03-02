import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/constants/constants.dart';
import 'package:qawafi_app/features/crpt/presentation/pages/ListCallerTonesCategory.dart';
//import 'package:testapp/ProverbsPage.dart';

class AlphabetCrptPage extends StatelessWidget {
  const AlphabetCrptPage();
  static const String routeName = '/AlphabetCrpt';
  static route() => MaterialPageRoute(
        builder: (context) => const AlphabetCrptPage(),
        settings: const RouteSettings(name: routeName),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QawafiAppBar(
        title: 'رنـات الإنتظار',
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
                "يرجي اختيار الحرف الذي يبدأ به اسمك من القائمة ادناه لتتمكن من تخصيص رنة الانتظار الخاصة بك بسهولة ",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14, color: Colors.white),
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
                              CallerTonesCategoryPage(writtenLetter: WrittenLetter),
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
