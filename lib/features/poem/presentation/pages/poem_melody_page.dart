import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/appbar.dart';
import '../../../../core/common/widgets/background_image_scaffold.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/poem/poem_bloc.dart';
import '../widgets/poem_list_widget.dart';

class PoemMelodyPage extends StatefulWidget {
  const PoemMelodyPage({super.key, this.melody});

  static const String routeName = 'PoemMelody';

  static route({required String? melody}) => MaterialPageRoute(
        builder: (context) => PoemMelodyPage(melody: melody),
        settings: const RouteSettings(name: routeName),
      );

  final String? melody;

  @override
  State<PoemMelodyPage> createState() => _PoemMelodyPageState();
}

class _PoemMelodyPageState extends State<PoemMelodyPage> {
  @override
  void initState() {
    context.read<PoemBloc>().add(PoemGetByCategoryAndMelody(
          category: widget.melody == null ? 'Recite' : 'Melhona',
          melody: widget.melody,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(title: widget.melody ?? 'إلقاء'),
        body: Container(
          width: double.infinity,
          child: Column(children: [
            BlocConsumer<PoemBloc, PoemState>(
              listener: (context, state) {
                if (state is PoemFailure) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is PoemLoading) {
                  return const Expanded(
                    child: Center(
                      child: Loader(),
                    ),
                  );
                }
                if (state is PoemSuccess) {
                  return Expanded(
                    child: PoemList(
                      poemDataModel: state.poemDataModel,
                    ),
                  );
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
