import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';

import '../../../../../core/common/widgets/app_button.dart';
import '../../../../../core/constants/constants.dart';

// ignore: must_be_immutable
class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({
    super.key,
    required this.onPressed,
    required this.isApproved,
  });
  final VoidCallback onPressed;
  bool isApproved;

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late ScrollController _scrollController;
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _isAtBottom = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'سياسة الخصوصية'),
        body: Container(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'سياسة الخصوصية لمنصة قوافي',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppPallete.privacyPolicyHeaderColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Text(
                            Constants.privacyPolicyText,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: AppPallete.whiteColor.withOpacity(0.6),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButton(
                        onPressed: () {
                          if (_isAtBottom) {
                            Navigator.pop(context);
                            widget.onPressed();
                          } else {
                            showSnackBar(context, "لابد من قراءة السياسات ");
                          }
                        },
                        text: 'الموافقة على سياسات الخدمة',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           widget.onPressed();
            //           widget.isApproved = !widget.isApproved;
            //         });
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           color: AppPallete.secondaryColor,
            //         ),
            //         height: 20,
            //         width: 20,
            //         child: Center(
            //           child: widget.isApproved ? AppIcon.check : Container(),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     const Text('اوافق على سياسة الخصوصية')
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }
}
