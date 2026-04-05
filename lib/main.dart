import 'dart:developer';
import 'dart:io';
import 'package:qawafi_app/features/competition/presentation/bloc/competition_bloc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qawafi_app/core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import 'package:qawafi_app/core/firebase/firebase_api.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/core/theme/theme.dart';
import 'package:qawafi_app/core/utils/SizeConfigPercentage.dart';
import 'package:qawafi_app/features/account/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:qawafi_app/features/ads/presentation/bloc/advertisement_bloc.dart';
import 'package:qawafi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:qawafi_app/features/crpt/presentation/bloc/CallerTonesCategory_bloc.dart';
import 'package:qawafi_app/features/crpt/presentation/bloc/CallerTones_bloc.dart';
import 'package:qawafi_app/features/crpt/presentation/bloc/audioPlayer/audio_player_bloc.dart';
import 'package:qawafi_app/features/customer/domain/entites/subscription.dart';
import 'package:qawafi_app/features/customer/presentation/bloc/wallet_bloc.dart';
import 'package:qawafi_app/features/customer/presentation/bloc/wallet_transactions_bloc/wallet_transactions_bloc.dart';
import 'package:qawafi_app/features/favorite/presentation/bloc/favorites_bloc.dart';
import 'package:qawafi_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:qawafi_app/features/libyan_titles/presentation/bloc/libyan_title_bloc.dart';
import 'package:qawafi_app/features/melody/presentation/bloc/melody_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/most_streamed_and_newest/bloc/most_streamed_and_newest_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/poem/poem_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/search/poem_search_bloc.dart';
import 'package:qawafi_app/features/popularProverbs/presentation/bloc/popularProverbs_bloc.dart';
import 'package:qawafi_app/features/purpose/presentation/bloc/purpose_bloc.dart';
import 'package:qawafi_app/features/quatrains/presentation/bloc/favorite/favorite_quatrain_bloc.dart';
import 'package:qawafi_app/features/quatrains/presentation/bloc/quatrain/quatrain_bloc.dart';
import 'package:qawafi_app/features/quatrains_category/presentation/bloc/quatrains_category_bloc.dart';
import 'package:qawafi_app/features/reels/presentation/bloc/reels_bloc.dart';
import 'package:qawafi_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:qawafi_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:qawafi_app/features/spoken_proverbs/presentation/bloc/spoken_proverb_bloc/spoken_proverb_bloc.dart';
import 'package:qawafi_app/features/spoken_proverbs/presentation/bloc/spoken_proverb_category_bloc/spoken_proverb_category_bloc.dart';
import 'package:qawafi_app/features/storyProverb/presentation/bloc/favorite/favorite_storyproverb_bloc.dart';
import 'package:qawafi_app/features/storyProverb/presentation/bloc/listProverbStory/list_story_proverb_bloc.dart';
import 'package:qawafi_app/features/storyProverb/presentation/bloc/playerProverbStory/playerStoryProverb_bloc.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/paymnet_bloc/payment_bloc.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/subscription_management_bloc/subscription_management_bloc.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/verify_subscription_bloc/verify_subscription_bloc.dart';
import 'package:qawafi_app/features/support/presentation/bloc/contact_bloc.dart';
import 'package:qawafi_app/features/wordsMeaning/presentation/bloc/word_bloc.dart';
import 'package:qawafi_app/init_dependencies.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/common/entities/user.dart';
import 'core/utils/navigator_key.dart';
import 'core/utils/size_config.dart';
import 'features/account/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'features/audio_player/presentation/bloc/bloc/poem_bloc_bloc.dart';
import 'features/poet/presentation/bloc/poet_bloc/poet_bloc.dart';
import 'features/webview/presentation/bloc/web_view_bloc_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();

  await initDependencies();
  LocalStorage localStorage = serviceLocator<LocalStorage>();

  User? user;
  Subscription? subscription;
  try {
    user = await localStorage.user;
    subscription = await localStorage.mySubscription;
  } catch (e) {
    log(e.toString());
  }
  try {
    await Firebase.initializeApp();
    FirebaseApi firebaseApi = serviceLocator<FirebaseApi>();
    firebaseApi.initialize();
  } catch (e) {
    log(e.toString());
  }
  AwesomeNotifications().initialize(
    'resource://drawable/ic_notification', // Reference to your drawable icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance:
            NotificationImportance.Max, // Set to Max for high importance
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        locked: false,
      )
    ],
  );
  bool isAllowrdToSendNotifications =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowrdToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PurposeBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PoemBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MelodyBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PopularProverbsBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ListStoryProverbBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PlayerStoryProverbBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<WordBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PoetBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MostStreamedAndNewestBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PoemSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SplashBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<QuatrainBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<QuatrainsCategoryBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoriteQuatrainBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AdvertisementBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ReelsBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SubscriptionManagementBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PaymentBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<VerifySubscriptionBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<WalletBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AppUserSubscriptionCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoritesBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoriteStoryProverbBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserInfoBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ChangePasswordBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<WalletTransactionsBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoriteStoryProverbBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SpokenProverbBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SpokenProverbCategoryBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ContactBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ContactBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<CallerTonesCategoryBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<CallerTonesBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AudioPlayerBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<LibyanTitleBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<WebViewBlocBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PoemBlocBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<CompetitionBloc>(),
        ),
      ],
      child: MyApp(user: user, subscription: subscription),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.user, required this.subscription})
      : super(key: key);
  final User? user;
  final Subscription? subscription;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    context.read<AppUserCubit>().updateUser(widget.user);
    context.read<AppUserSubscriptionCubit>().update(widget.subscription);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: const Locale(
          'ar'), // Set the locale to an RTL language (e.g., Arabic)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // Arabic (RTL)
      ],
      debugShowCheckedModeBanner: false,
      title: "منصة قوافي",

      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          SizeConfigPercentage().init(context);
          SizeConfig().init(context);
          return const SplashScreen();
        },
      ),
    );
    // home: const SplashScreen(),
  }
}
