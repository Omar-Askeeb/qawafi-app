import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';

import '../../../poem/presentation/pages/poem_melody_page.dart';
import '../bloc/melody_bloc.dart';

class MelodyPage extends StatefulWidget {
  MelodyPage({super.key});

  static const String routeName = 'Melody';

  static route() => MaterialPageRoute(
        builder: (context) => MelodyPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<MelodyPage> createState() => _MelodyPageState();
}

class _MelodyPageState extends State<MelodyPage> {
  @override
  void initState() {
    context.read<MelodyBloc>().add(MelodyGetAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'ملحون'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //           StaggeredGridView.countBuilder(
              //   crossAxisCount: 2, // Two columns
              //   itemCount: items.length,
              //   itemBuilder: (BuildContext context, int index) {  return ElevatedButton(
              //                   style: ElevatedButton.styleFrom(
              //                     primary: AppPallete.secondaryColor.withOpacity(.26),
              //                     onPrimary: Colors.white,
              //                     shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8),
              //                     ),
              //                   ),
              //                   onPressed: () {
              //                     Navigator.push(
              //                         context, PoemMelodyPage.route(melody: ''));
              //                   },
              //                   child: Text(
              //                     items[index],
              //                     style: TextStyle(fontSize: 16),
              //                   ),
              //                 );},
              //   staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
              //   mainAxisSpacing: 5.0,
              //   crossAxisSpacing: 10.0,
              // ),
              BlocConsumer<MelodyBloc, MelodyState>(
                listener: (context, state) {
                  if (state is MelodyFailuer) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is MelodyLoading) {
                    return const Loader();
                  }
                  if (state is MelodySuccess) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.melodies.length,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  AppPallete.secondaryColor.withOpacity(.26),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PoemMelodyPage.route(
                                      melody: state.melodies[index].name));
                            },
                            child: Text(
                              state.melodies[index].name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
