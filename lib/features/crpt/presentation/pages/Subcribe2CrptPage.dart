import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/app_button.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/send_SMS.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';

// ignore: must_be_immutable
class Subscribe2CrptPage extends StatefulWidget {
  static const String routeName = 'Subscribe2Crpt';

  static route({required String toneCodeM, required String toneCodeL}) =>
      MaterialPageRoute(
        builder: (context) =>
            Subscribe2CrptPage(toneCodeM: toneCodeM, toneCodeL: toneCodeL),
        settings: const RouteSettings(name: routeName),
      );

  final String toneCodeM;
  final String toneCodeL;

  Subscribe2CrptPage({
    super.key,
    required this.toneCodeM,
    required this.toneCodeL,
  });

  @override
  State<Subscribe2CrptPage> createState() => _Subscribe2CrptPageState();
}

// قائمة لتخزين نغمات الرنين
List<Ringtone> myRingtoneList = [];

class _Subscribe2CrptPageState extends State<Subscribe2CrptPage> {
  int _selectedMethodId = 0;

  _setSelectedMethod(int? value) {
    setState(() {
      _selectedMethodId = value ?? 0;
    });
  }

  @override
  void initState() {
    // إعداد قائمة نغمات الرنين هنا
    myRingtoneList = [
      Ringtone(
          companyid: 1,
          toneCode: widget.toneCodeM,
          companyName: "المدار",
          subscriptionFee: 0.5,
          companyImage: AppImages.libyanaIcon),
      // Ringtone(
      //     companyid: 2,
      //     toneCode: widget.toneCodeL,
      //     companyName: "الليبيانا",
      //     subscriptionFee: 1,
      //     companyImage: AppImages.almadarIcon),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Cairo'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'اختر شبكة الاتصال التي ترغب في الاشتراك من خلالها',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.blackColor),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'يرجى تحديد شبكة المدار للاستمرار',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppPallete.blackColor.withOpacity(0.3)),
                  ),
                  Text(
                    'سيتم توجيهك الى الرسائل النصية الخاصة بجهازك لإتمام عملية الإشتراك',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppPallete.blackColor.withOpacity(0.3)),
                    textAlign: TextAlign.center,
                  ),
                  RadioButtonList(
                    myRingtone: myRingtoneList, // تمرير القائمة هنا
                    onSelect: _setSelectedMethod,
                    selectedValue: _selectedMethodId,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      onPressed: () {
                        if(_selectedMethodId==0)
                        {
                          showSnackBar(context, 'اختر شبكة الاتصال التي ترغب في الاشتراك من خلالها');
                          return;
                        }
                        sendSMS(myRingtoneList.firstWhere((test) => test.companyid == _selectedMethodId).toneCode,"128");
                      },
                      text: "أرسل الرمز للإشتراك",
                      height: 60,
                      color: AppPallete.blackColor,
                      borderColor: AppPallete.transparentColor,
                      opicity: 1,
                    ),
                  ),
                  // Expanded(
                  //   child: Column(
                  //     children: [

                  //     ],
                  //   ),
                  // ),
                ]),
          ),
        ),
      ),
    );
  }
}

class RadioButtonList extends StatelessWidget {
  final List<Ringtone> myRingtone;
  final Function(int? value) onSelect;
  final int? selectedValue;

  RadioButtonList({
    super.key,
    required this.myRingtone,
    required this.onSelect,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: myRingtone.length,
      itemBuilder: (context, index) {
        final isComingSoon = myRingtone[index].toneCode.trim() == 'null';

        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFECECEC), width: 1),
            color: isComingSoon
                ? Colors.grey
                    .withOpacity(0.2) // تغيير لون الخلفية إذا كانت "قريباً"
                : Colors.white,
          ),
          child: ListTile(
            trailing: Radio<int>(
              value: myRingtone[index].companyid,
              groupValue: selectedValue,
              activeColor: AppPallete.primaryColor,
              onChanged: isComingSoon
                  ? null // تعطيل Radio إذا كانت "قريباً"
                  : (int? value) {
                      onSelect(value);
                    },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      myRingtone[index].companyImage,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      myRingtone[index].companyName,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppPallete.blackColor,
                        fontWeight:
                            isComingSoon ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isComingSoon) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppPallete.secondaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'قريباً',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  _getCost(myRingtone[index].subscriptionFee.toString()).isEmpty
                      ? "مشكلة في عرض السعر"
                      : _getCost(myRingtone[index].subscriptionFee.toString()),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppPallete.blackColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getCost(String subscriptionFee) {
    return "$subscriptionFee د.ل";
  }
}

class Ringtone {
  final int companyid;
  final String toneCode;
  final String companyName;
  final double subscriptionFee;
  final String companyImage;

  // Constructor to initialize the model with values
  Ringtone({
    required this.companyid,
    required this.toneCode,
    required this.companyName,
    required this.subscriptionFee,
    required this.companyImage,
  });
}
