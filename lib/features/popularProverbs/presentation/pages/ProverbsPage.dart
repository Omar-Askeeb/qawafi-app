import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/popularProverbs/presentation/bloc/popularProverbs_bloc.dart';

class ProverbsPage extends StatefulWidget {
  static const String routeName = '/Proverbs';
  static route({required String writtenLetter}) => MaterialPageRoute(
        builder: (context) => ProverbsPage(writtenLetter: writtenLetter),
        settings: const RouteSettings(name: routeName),
      );
  const ProverbsPage({required this.writtenLetter});
  final String writtenLetter;

  @override
  State<ProverbsPage> createState() => _ProverbsPageState();
}

class _ProverbsPageState extends State<ProverbsPage> {
  @override
  void initState() {
    context
        .read<PopularProverbsBloc>()
        .add(GetPopularProverbsByAlpha(Alpha: widget.writtenLetter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QawafiAppBar(
        title: " حرف " + "( " + widget.writtenLetter + " )",
      ),
      body: Container(
        color: Colors.black,
        child: BlocConsumer<PopularProverbsBloc, PopularProverbsState>(
          listener: (context, state) {
            if (state is PopularProverbsFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is PopularProverbsLoading) {
              return Loader();
            }
            if (state is PopularProverbsLoaded) {
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: state.popularProverbs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(76, 64, 40, 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(76, 64, 40, 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          state.popularProverbs[index].titel,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          state.popularProverbs[index]
                                              .descrption,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 50),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Text(
                                              'إغلاق',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              state.popularProverbs[index].titel,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            if (state is PopularProverbsFailure) {
              Refresh(
                message: 'لا يوجد اتصال بالأنترنت',
                onRefresh: () => context.read<PopularProverbsBloc>().add(
                    GetPopularProverbsByAlpha(Alpha: widget.writtenLetter)),
              );
            }
            return Refresh(
              message: 'مشكلة ما الرجاء المحاولة مجدداً',
              onRefresh: () => context
                  .read<PopularProverbsBloc>()
                  .add(GetPopularProverbsByAlpha(Alpha: widget.writtenLetter)),
            );
          },
        ),
      ),
    );
  }
}
