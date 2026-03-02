import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/crpt/presentation/bloc/CallerTonesCategory_bloc.dart';
import 'package:qawafi_app/features/crpt/presentation/pages/CallerTonesAudio.dart';

class ListmaleAndfemale extends StatefulWidget {
  @override
  State<ListmaleAndfemale> createState() => _ListmaleAndfemaleState();
  const ListmaleAndfemale({required this.alpha, required this.gender});
  final String alpha;
  final String gender;
}

class _ListmaleAndfemaleState extends State<ListmaleAndfemale> {
  @override
  void initState() {
    context.read<CallerTonesCategoryBloc>().add(
        CallerTonesCategoryByAlpha(alpha: widget.alpha, gender: widget.gender));
    super.initState();
    //_tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<CallerTonesCategoryBloc, CallerTonesCategoryState>(
        listener: (context, state) {
          if (state is CallerTonesCategoryFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CallerTonesCategoryLoading) {
            return Loader();
          }
          if (state is CallerTonesCategoryLoaded) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'قائمة الرنات الخاصة بحرف   ' + widget.alpha,
                      style: TextStyle(
                        color: AppPallete.secondaryColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: state.callerTonesCategory.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // CircleAvatar(
                            //     backgroundColor: Colors.black,
                            //     child:
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.play_circle,
                              size: 35,
                              color: AppPallete.secondaryColor,
                            ),
                            // ),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CallerTonesAudio(
                                          id:  state.callerTonesCategory[index].callerTonesCategoryId,
                                          Name: state.callerTonesCategory[index].personName,),
                                    ),
                                  );
                                },
                                child: Text(
                                  state.callerTonesCategory[index].personName,
                                  style: TextStyle(
                                    color: AppPallete.secondaryColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                AppImages.crptAudio,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is CallerTonesCategoryFailure) {
            Refresh(
              message: state.message,
              onRefresh: () => context.read<CallerTonesCategoryBloc>().add(
                  CallerTonesCategoryByAlpha(
                      alpha: widget.alpha, gender: widget.gender)),
            );
          }
          return Refresh(
            message: 'مشكلة ما الرجاء المحاولة مجدداً',
            onRefresh: () => context.read<CallerTonesCategoryBloc>().add(
                CallerTonesCategoryByAlpha(
                    alpha: widget.alpha, gender: widget.gender)),
          );
        },
      ),
    );
  }
}
