import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/features/wordsMeaning/presentation/bloc/word_bloc.dart';
import 'package:qawafi_app/features/wordsMeaning/presentation/pages/WordSearchBar.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/constants/app_images.dart';

class WordsMeaningPage extends StatefulWidget {
  const WordsMeaningPage();

  static const String routeName = '/WordsMeaningPage';
  static route() => MaterialPageRoute(
        builder: (context) => const WordsMeaningPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  _WordsMeaningPageState createState() => _WordsMeaningPageState();
}

class _WordsMeaningPageState extends State<WordsMeaningPage> {
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 10;
  Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<WordBloc>().add(GetWordsEvent(
        pageNumber: 1, pageSize: _pageSize, isFirstFetch: true, query: ''));
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      final bloc = context.read<WordBloc>();
      final currentState = bloc.state;
      if (currentState is WordLoaded && !currentState.hasReachedMax) {
        bloc.add(GetWordsEvent(
            pageNumber: currentState.pageNumber + 1,
            pageSize: _pageSize,
            query: ''));
      }
    }
  }

  void _toggleExpand(int index) {
    setState(() {
      _expandedStates[index] = !_expandedStates[index]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QawafiAppBar(
        title: 'معاني الكلمات',
      ),
      body: Column(
        children: [
          WordSearchBar(),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<WordBloc, WordState>(
              builder: (context, state) {
                if (state is WordInitial ||
                    (state is WordLoading && state is! WordLoaded)) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WordLoaded) {
                  return Container(
                    color: const Color(0xFFEAC578).withOpacity(0.001),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.words.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index >= state.words.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final word = state.words[index];
                        final isExpanded = _expandedStates[index] ?? false;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (!_expandedStates.containsKey(index)) {
                                _expandedStates[index] = false;
                              }
                              _toggleExpand(index);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFEAC578).withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      word.word,
                                      style:
                                          TextStyle(color: Color(0xFFEAC578)),
                                    ),
                                    trailing: Icon(
                                      isExpanded
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down,
                                      color: Color(0xFFEAC578),
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                    firstChild: Container(),
                                    secondChild: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Text(
                                        word.meaning,
                                        style:
                                            TextStyle(color: Color(0xFFEAC578)),
                                      ),
                                    ),
                                    crossFadeState: isExpanded
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: Duration(milliseconds: 300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is WordFailure) {
                  final pageNumber = state is WordLoaded ? state.pageNumber : 1;
                  if (context.read<AppUserCubit>().state is! AppUserLoggedIn) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // الشعار
                          Image.asset(
                            AppImages.LOGO,
                            height: 150,
                          ),
                          SizedBox(height: 20), // المسافة بين الشعار والزر

                          // رسالة عدم وجود اتصال بالإنترنت
                          Text(
                            'الرجاء تسجيل الدخول اولاً',
                            style: TextStyle(
                              fontSize: 18, // حجم الخط
                              color: Colors.white, // لون النص
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                      child: Refresh(
                    message: '${state.message}',
                    onRefresh: () {
                      context.read<WordBloc>().add(GetWordsEvent(
                          pageNumber: pageNumber,
                          pageSize: _pageSize,
                          query: ''));
                    },
                  ));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
