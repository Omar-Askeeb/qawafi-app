import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_pallete.dart';

class Aboutapp extends StatelessWidget {
  const Aboutapp({super.key, this.color});
  final Color? color;
  static const String routeName = '/Aboutapp';

  static route() => MaterialPageRoute(
        builder: (context) => const Aboutapp(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
          title: 'حول التطبيق',
        ),
        body: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppImages.logoAbout,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  '1.0.0 V',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        // النص الأول
                        Text(
                          'مرحبًا بك في تطبيق قوافي  وجهتك المثالية لاكتشاف والاستمتاع بالشعر الشعبي',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 14, // حجم الخط
                          ),
                        ),

                        SizedBox(height: 10), // مسافة بين النصوص
                        Text(
                          'من نحن',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 14, // حجم الخط
                          ),
                        ),
                        // نص من نحن
                        Text(
                          'مكتبة تضم اضخم محتوى للشعراء على مستوى ليبيا حيث يمكنك الاستماع الى العديد من انواع الشعر المفضلة لديك، كما تحتوي على العديد من الأمثال والحكم، والرباعيات. كل هذا واكثر سيتواجد على تطبيق قوافي.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 14, // حجم الخط
                          ),
                        ),

                        SizedBox(height: 10), // مسافة بين النصوص
                        // Text(
                        //   'فئات محتوى قوافي',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     color: AppPallete.whiteColor, // لون النص
                        //     fontSize: 14, // حجم الخط
                        //   ),
                        // ),
                        // Text(
                        //   'تتضمن منصة قوافي كل أصناف وفئات وأغراض المحتوى: الثقافي والشعري وهي على النحو الآتي:\n'
                        //       ' القصائد الشعرية\n'
                        //       ' الرباعيات\n'
                        //       ' الأمثال والحكم الليبية المحكية والمكتوبة\n'
                        //       'حكاية مثل\n'
                        //       ' المسميات الشعبية الليبية\n'
                        //       ' قاموس الكلمات الشعبية',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     color: AppPallete.whiteColor, // لون النص
                        //     fontSize: 16, // حجم الخط
                        //   ),
                        // ),
                        SizedBox(height: 20),

                        Text(
                          'الإصدار: 1.0.0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 16, // حجم الخط
                            fontWeight: FontWeight.bold, //  الخط غامق
                          ),
                        ),

                        SizedBox(height: 20), // مسافة بين النصوص والأيقونات

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                const url =
                                    'https://www.facebook.com/Qawafi.ly';
                                await launchUrl(Uri.parse(url));
                              },
                              icon: Icon(Icons.facebook,
                                  color: AppPallete.whiteColor, size: 30),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                const url =
                                    'https://www.instagram.com/qawafi.ly/';
                                await launchUrl(Uri.parse(url));
                              },
                              icon: Icon(FontAwesomeIcons.instagram,
                                  color: AppPallete.whiteColor,
                                  size: 30), // استخدام أيقونة إنستغرام
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                const url = 'https://www.tiktok.com/@qawafi.ly';
                                await launchUrl(Uri.parse(url));
                              },
                              icon: Icon(Icons.tiktok,
                                  color: AppPallete.whiteColor,
                                  size: 30), // استخدام أيقونة تيك توك
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                const url = 'https://qawafi.ly';
                                await launchUrl(Uri.parse(url));
                              },
                              icon: Icon(FontAwesomeIcons.globe,
                                  color: AppPallete.whiteColor, size: 30),
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // مسافة بعد الأيقونات

                        // نص التواصل
                        Text(
                          textDirection: TextDirection.ltr,
                          ' info@qawafi.ly :للتواصل ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 16, // حجم الخط
                          ),
                        ),

                        SizedBox(height: 10), // مسافة بين النصوص

                        // رقم الهاتف
                        Text(
                          '+218 91-0734070',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 16, // حجم الخط
                          ),
                        ),
                        SizedBox(height: 40), // مسافة بين النصوص

                        // جذور التواصل لتقنية المعلومات
                        Text(
                          'جذور التواصل للاتصالات و تقنية المعلومات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppPallete.whiteColor, // لون النص
                            fontSize: 16, // حجم الخط
                          ),
                        ),

                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class GradientPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF1c1c14),
//               Color(0xFF20200c),
//               Color(0xFF0c0c0c),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 40), // ترك مسافة 40 من الأعلى
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Image.asset(
//                   'assets/images/135.png',
//                   width: 150, // ضبط عرض الصورة
//                   height: 150, // ضبط ارتفاع الصورة
//                 ),
//               ),
//             ),
//             SizedBox(height: 30), // مسافة بين الشعار والنص

//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: Column(
//                     children: [
//                       // النص الأول
//                       Text(
//                         'مرحبًا بك في تطبيق قوافي  وجهتك المثالية لاكتشاف والاستمتاع بالشعر الشعبي',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 14, // حجم الخط
//                         ),
//                       ),

//                       SizedBox(height: 10), // مسافة بين النصوص
//                       Text(
//                         'من نحن',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 14, // حجم الخط
//                         ),
//                       ),
//                       // نص من نحن
//                       Text(
//                         'مكتبة تضم اضخم محتوى للشعراء على مستوى ليبيا حيث يمكنك الاستماع الى العديد من انواع الشعر المفضلة لديك، كما تحتوي على العديد من الأمثال والحكم، والرباعيات. كل هذا واكثر سيتواجد على تطبيق قوافي.',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 14, // حجم الخط
//                         ),
//                       ),

//                       SizedBox(height: 10), // مسافة بين النصوص
//                       Text(
//                         'فئات محتوى قوافي',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 14, // حجم الخط
//                         ),
//                       ),
//                       Text(
//                         'تتضمن منصة قوافي كل أصناف وفئات وأغراض المحتوى: الثقافي والشعري وهي على النحو الآتي:\n'
//                             ' القصائد الشعرية\n'
//                             ' الرباعيات\n'
//                             ' الأمثال والحكم الليبية المحكية والمكتوبة\n'
//                             'حكاية مثل\n'
//                             ' المسميات الشعبية الليبية\n'
//                             ' قاموس الكلمات الشعبية',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 16, // حجم الخط
//                         ),
//                       ),
//                       SizedBox(height: 20),

//                       Text(
//                         'الإصدار: 1.0.0',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 16, // حجم الخط
//                           fontWeight: FontWeight.bold, //  الخط غامق
//                         ),
//                       ),

//                       SizedBox(height: 20), // مسافة بين النصوص والأيقونات

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               //  ايقونة الفيس
//                             },
//                             icon: Icon(Icons.facebook, color: AppPallete.whiteColor, size: 30),
//                           ),
//                           SizedBox(width: 20),
//                           IconButton(
//                             onPressed: () {
//                               // ايقونة إنستغرام
//                             },
//                             icon: Icon(FontAwesomeIcons.instagram, color: AppPallete.whiteColor, size: 30), // استخدام أيقونة إنستغرام
//                           ),
//                           SizedBox(width: 20),
//                           IconButton(
//                             onPressed: () {
//                               // تيك توك
//                             },
//                             icon: Icon(Icons.tiktok, color:  AppPallete.whiteColor, size: 30), // استخدام أيقونة تيك توك
//                           ),
//                           SizedBox(width: 20),
//                           IconButton(
//                             onPressed: () {
//                               // الموقع الالكتروني
//                             },
//                             icon: Icon(FontAwesomeIcons.globe, color: AppPallete.whiteColor, size: 30),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20), // مسافة بعد الأيقونات

//                       // نص التواصل
//                       Text(
//                         ' info@qawafi.com :للتواصل ',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 16, // حجم الخط
//                         ),
//                       ),

//                       SizedBox(height: 10), // مسافة بين النصوص

//                       // رقم الهاتف
//                       Text(
//                         'الهاتف: +1234567890',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 16, // حجم الخط
//                         ),
//                       ),
//                       SizedBox(height: 40), // مسافة بين النصوص

//                       // جذور التواصل لتقنية المعلومات
//                       Text(
//                         'جذور التواصل لتقنية المعلومات',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppPallete.whiteColor, // لون النص
//                           fontSize: 16, // حجم الخط
//                         ),
//                       ),

//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 15), // مسافة بين النصوص




//           // مسافة بين النصوص
//             // يشغل المساحة المتبقية
//           ],
//         ),
//       ),
//     );
//   }
// }