part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initPurpose();
  _initPoem();
  _initPopularProverbs();
  _initStoryProverb();
  _initMelody();
  _initWordsMeaning();
  _initPoet();
  _initSplash();
  _initQuatrain();
  _initQuatrainCategory();
  _initAdvertisement();
  _initReels();
  _initSubscriptionManagement();
  _initPayment();
  _initCustomer();
  _initFavorites();
  _initSupport();
  _initSpokenProverbs();
  _initCallerTonesCategory();
  _initLibyanTitles();
  _initHome();
  _initCompetition();
  // _initBlog();

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());
  serviceLocator.registerLazySingleton<FirebaseApi>(() => FirebaseApi());

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'Qawafi'),
  );
  serviceLocator.registerLazySingleton(
    () => ApiClient(
      httpClient: http.Client(),
      localStorage: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(
    () => PoemBlocBloc(
      getPoemById: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => WebViewBlocBloc(
      appUserCubit: serviceLocator(),
      appUserSubscriptionCubit: serviceLocator(),
      localStorage: serviceLocator(),
      mySubscription: serviceLocator(),
      refreshToken: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AppUserSubscriptionCubit(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        httpClient: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => Login(
        authRepository: serviceLocator(),
        putNotificationToken: serviceLocator(),
        firebaseApi: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RequestOtp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUp(
        authRepository: serviceLocator(),
        firebaseApi: serviceLocator(),
        putNotificationToken: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetResetPasswordToken(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ResetPassword(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RefreshToken(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ResetDeviceId(
        authRepository: serviceLocator(),
      ),
    )
    // ..registerFactory(
    //   () => UserLogin(
    //     serviceLocator(),
    //   ),
    // )
    // ..registerFactory(
    //   () => CurrentUser(
    //     serviceLocator(),
    //   ),
    // )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        login: serviceLocator(),
        requestOtp: serviceLocator(),
        signUp: serviceLocator(),
        getResetPasswordToken: serviceLocator(),
        resetPassword: serviceLocator(),
        appUserCubit: serviceLocator(),
        localStorage: serviceLocator(),
        appUserSubscriptionCubit: serviceLocator(),
        mySubscription: serviceLocator(),
        resetDeviceId: serviceLocator(),
      ),
    );
}

void _initPurpose() {
  // Datasource
  serviceLocator
    ..registerFactory<PurposeRemoteDatasource>(
      () => PurposeRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<PurposeRepository>(
      () => PurposeRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchPurposeAll>(
      () => FetchPurposeAll(
        purposeRepository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => PurposeBloc(
        fetchPurposeAll: serviceLocator(),
      ),
    );
}

void _initMelody() {
  // Datasource
  serviceLocator
    ..registerFactory<MelodyRmoteDatasource>(
      () => MelodyRmoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )
    // Repository

    ..registerFactory<MelodyRepository>(
      () => MelodyRepositoryImpl(
        melodyRmoteDatasource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<GetMelodies>(
      () => GetMelodies(
        melodyRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => MelodyBloc(
        getMelodies: serviceLocator(),
      ),
    );
}

void _initPoem() {
  // Datasource
  serviceLocator
    ..registerFactory<PoemRemoteDatasource>(
      () => PoemRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )
    // Repository

    ..registerFactory<PoemRepository>(
      () => PoemRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<GetPoemByPurposeAndCategory>(
      () => GetPoemByPurposeAndCategory(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetPoemByCategoryAndMelody>(
      () => GetPoemByCategoryAndMelody(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetPoemById>(
      () => GetPoemById(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetPoemByPoetId>(
      () => GetPoemByPoetId(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetMostStreamed>(
      () => GetMostStreamed(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetNewest>(
      () => GetNewest(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<SearchPoems>(
      () => SearchPoems(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<Add2Favorite>(
      () => Add2Favorite(
        poemRepository: serviceLocator(),
      ),
    )
    ..registerFactory<Remove2Favorite>(
      () => Remove2Favorite(
        poemRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => PoemBloc(
        getPoemByPurposeAndCategory: serviceLocator(),
        getPoemByCategoryAndMelody: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => PoemSearchBloc(
        searchPoems: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FavoriteBloc(
        add2favorite: serviceLocator(),
        remove2favorite: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => MostStreamedAndNewestBloc(
        getMostStreamed: serviceLocator(),
        getNewest: serviceLocator(),
      ),
    );
}

void _initPopularProverbs() {
  // Datasource
  serviceLocator
    ..registerFactory<PopularProverbsRemoteDataSource>(
      () => PopularProverbsRemoteDataSourceImp(
        httpClient: serviceLocator<ApiClient>(),
      ),
    )
    // Repository
    ..registerFactory<PopularProverbsRepository>(
      () => PopularProverbsRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => GetProverbsbyalpha(
        popularProverbsRepository: serviceLocator(),
      ),
    )

    // ..registerFactory(
    //   () => UserLogin(
    //     serviceLocator(),
    //   ),
    // )
    // ..registerFactory(
    //   () => CurrentUser(
    //     serviceLocator(),
    //   ),
    // )
    // Bloc
    ..registerLazySingleton(
      () => PopularProverbsBloc(
        getPopularProverbs: serviceLocator(),
      ),
    );
}

void _initStoryProverb() {
  // Datasource
  serviceLocator
    ..registerFactory<ProverbStoryRemoteDataSource>(
      () => ProverbStoryRemoteDataSourceImpl(
        httpClient: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<ProverbStoryRepository>(
      () => ProverbStoryRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => GetProverbStories(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateFavoriteStatus(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetProverbStoriesById(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => StoryProverbAdd2Favorite(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => StoryProverbRemoveFromFavorite(
        repository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => PlayerStoryProverbBloc(
        //   getStoryProverb: serviceLocator(),
        updateStoryProverbFavorite: serviceLocator(),
        getProverbStoriesById: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ListStoryProverbBloc(
        getStoryProverb: serviceLocator(),
        // updateStoryProverbFavorite: serviceLocator(),
        // getProverbStoriesById: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FavoriteStoryProverbBloc(
        storyProverbAdd2Favorite: serviceLocator(),
        storyProverbRemoveFromFavorite: serviceLocator(),
        // updateStoryProverbFavorite: serviceLocator(),
        // getProverbStoriesById: serviceLocator(),
      ),
    );
}

void _initWordsMeaning() {
  // Datasource
  serviceLocator
    ..registerFactory<WordRemoteDataSource>(
      () => WordRemoteDataSourceImpl(
        httpClient: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<WordsRepository>(
      () => WordsRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => FetchWordsUseCase(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => WordBloc(
        fetchWords: serviceLocator(),
      ),
    );
}

void _initPoet() {
  // Datasource
  serviceLocator
    ..registerFactory<PoetRemoteDatasource>(
      () => PoetRemoteDatasourceImpl(
        apiClient: serviceLocator(),
      ),
    )
    // Repository

    ..registerFactory<PoetRepositroy>(
      () => PoetRepositroyImpl(
        remoteDataSource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchPoets>(
      () => FetchPoets(
        poetRepositroy: serviceLocator(),
      ),
    )
    ..registerFactory<FetchPoet>(
      () => FetchPoet(
        poetRepositroy: serviceLocator(),
      ),
    )
    ..registerFactory<FollowPoet>(
      () => FollowPoet(
        poetRepositroy: serviceLocator(),
      ),
    )
    ..registerFactory<UnFollowPoet>(
      () => UnFollowPoet(
        poetRepositroy: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => PoetBloc(
        fetchPoets: serviceLocator(),
        fetchPoet: serviceLocator(),
        getPoemByPoetId: serviceLocator(),
        followPoet: serviceLocator(),
        unFollowPoet: serviceLocator(),
      ),
    );
}

void _initSplash() {
  // Datasource

  // Bloc
  serviceLocator
    ..registerLazySingleton(
      () => SplashBloc(
        localStorage: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initQuatrain() {
  // Datasource
  serviceLocator
    ..registerFactory<QuatrainsRemoteDatasource>(
      () => QuatrainsRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<QuatrainsRepository>(
      () => QuatrainsRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchQuatrains>(
      () => FetchQuatrains(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<FetchQuatrainById>(
      () => FetchQuatrainById(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<QuatrainAdd2Favorite>(
      () => QuatrainAdd2Favorite(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<QuatrainRemoveFromFavorite>(
      () => QuatrainRemoveFromFavorite(
        repository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => QuatrainBloc(
        fetchQuatrainById: serviceLocator(),
        fetchQuatrains: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FavoriteQuatrainBloc(
        quatrainAdd2Favorite: serviceLocator(),
        quatrainRemoveFromFavorite: serviceLocator(),
      ),
    );
}

void _initQuatrainCategory() {
  // Datasource
  serviceLocator
    ..registerFactory<QuatrainsCategoryRemoteDatasource>(
      () => QuatrainsCategoryRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<QuatrainsCategoryRepository>(
      () => QuatrainsCategoryRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchQuatrainsCategory>(
      () => FetchQuatrainsCategory(
        repository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => QuatrainsCategoryBloc(
        fetchQuatrainsCategory: serviceLocator(),
      ),
    );
}

void _initAdvertisement() {
  // Datasource
  serviceLocator
    ..registerFactory<AdvertisementRemoteDatasource>(
      () => AdvertisementRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<AdvertisementRepository>(
      () => AdvertisementRepositoryImpl(
        adversimentRemoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchAdvertisement>(
      () => FetchAdvertisement(
        advertisementRepository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => AdvertisementBloc(
        fetchAdvertisement: serviceLocator(),
      ),
    );
}

void _initReels() {
  // Datasource
  serviceLocator
    ..registerFactory<ReelsRemoteDataSource>(
      () => ReelsRemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<ReelsRepository>(
      () => ReelsRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchReels>(
      () => FetchReels(
        repository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => ReelsBloc(
        fetchReels: serviceLocator(),
      ),
    );
}

void _initSubscriptionManagement() {
  // Datasource
  serviceLocator
    ..registerFactory<CostRemoteDatasource>(
      () => CostRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<PeriodRemoteDatasource>(
      () => PeriodRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<SubscriptionCostRepository>(
      () => SubscriptionCostRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )
    ..registerFactory<SubscriptionPeriodRepository>(
      () => SubscriptionPeriodRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchSubscriptionCost>(
      () => FetchSubscriptionCost(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<FetchSubscriptionPeriod>(
      () => FetchSubscriptionPeriod(
        repository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => SubscriptionManagementBloc(
        fetchSubscriptionCost: serviceLocator(),
        fetchSubscriptionPeriod: serviceLocator(),
        appUserCubit: serviceLocator(),
        appUserSubscriptionCubit: serviceLocator(),
        localStorage: serviceLocator(),
        mySubscription: serviceLocator(),
      ),
    );
}

void _initPayment() {
  // Datasource
  serviceLocator
    ..registerFactory<PaymentMethodRemoteDatasource>(
      () => PaymentMethodRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<PaymentMethodRepository>(
      () => PaymentMethodRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchPaymentMethods>(
      () => FetchPaymentMethods(
        repository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => PaymentBloc(
        fetchPaymentMethods: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => VerifySubscriptionBloc(
        subscribe: serviceLocator(),
        appUserCubit: serviceLocator(),
        appUserSubscriptionCubit: serviceLocator(),
        mySubscription: serviceLocator(),
        cancelSubscription: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    );
}

void _initCustomer() {
  // Datasource
  serviceLocator
    ..registerFactory<CustomerRemoteDatasource>(
      () => CustomerRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<CustomerRepository>(
      () => CustomerRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<Subscribe>(
      () => Subscribe(
        repository: serviceLocator(),
        refreshToken: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    )
    ..registerFactory<ChangePassword>(
      () => ChangePassword(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<CancelSubscription>(
      () => CancelSubscription(
        repository: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    )
    ..registerFactory<ChargeWallet>(
      () => ChargeWallet(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<PutNotificationToken>(
      () => PutNotificationToken(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<MySubscription>(
      () => MySubscription(
        repository: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    )
    ..registerFactory<UpdateUserInfo>(
      () => UpdateUserInfo(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<FetchWalletTransactions>(
      () => FetchWalletTransactions(
        repository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => WalletBloc(
        chargeWallet: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => WalletTransactionsBloc(
        fetchWalletTransactions: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ChangePasswordBloc(
        changePassword: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => UserInfoBloc(
        updateUserInfo: serviceLocator(),
        appUserCubit: serviceLocator(),
        localStorage: serviceLocator(),
      ),
    );
}

_initFavorites() {
  serviceLocator
    ..registerFactory<FavoriteRemoteDatasource>(
      () => FavoriteRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<FavoriteRepository>(
      () => FavoriteRepositoryImpl(
        remoteDatasource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchFavPoems>(
      () => FetchFavPoems(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<FetchFavProverbs>(
      () => FetchFavProverbs(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<FetchFavQuatrains>(
      () => FetchFavQuatrains(
        repository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => FavoritesBloc(
        fetchFavPoems: serviceLocator(),
        fetchFavProverbs: serviceLocator(),
        fetchFavQuatrains: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

_initSupport() {
  serviceLocator
    ..registerFactory<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImpl(
        httpClient: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<ContactRepository>(
      () => ContactRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<SentContactUseCase>(
      () => SentContactUseCase(
        repository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => ContactBloc(
        sentContactUseCase: serviceLocator(),
      ),
    );
}

_initSpokenProverbs() {
  serviceLocator
    ..registerFactory<SpokenProverbRemoteDatasource>(
      () => SpokenProverbRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<SpokenProverbRepository>(
      () => SpokenProverbRepositoryImpl(
        repository: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchSpokenProverbByCategory>(
      () => FetchSpokenProverbByCategory(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory<FetchSpokenProverbCategories>(
      () => FetchSpokenProverbCategories(
        repository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => SpokenProverbBloc(
        fetchSpokenProverbByCategory: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => SpokenProverbCategoryBloc(
        fetchSpokenProverbCategories: serviceLocator(),
      ),
    );
}

_initCallerTonesCategory() {
  serviceLocator
    ..registerFactory<CallerTonesRemoteDataSource>(
      () => CallerTonesRemoteDataSourceImp(
        httpClient: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<CallerTonesRepository>(
      () => CallerTonesRepositoryImp(
        remoteDataSource: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<CallerTonesCategoryGet>(
      () => CallerTonesCategoryGet(
        callerTonesRepository: serviceLocator(),
      ),
    )
    ..registerFactory<CallerTonesGet>(
      () => CallerTonesGet(
        callerTonesRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => CallerTonesCategoryBloc(
        getCallerTonesCategory: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AudioPlayerBloc(),
    )
    ..registerLazySingleton(
      () => CallerTonesBloc(
        getCallerTones: serviceLocator(),
      ),
    );
}

_initLibyanTitles() {
  serviceLocator
    ..registerFactory<LibyanTitleRemoteDatasource>(
      () => LibyanTitleRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<LibyanTitleRepository>(
      () => LibyanTitleRepositoryImpl(
        libyanTitleRemoteDatasource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )

    // Usecases
    ..registerFactory<FetchLibyanTitles>(
      () => FetchLibyanTitles(
        repository: serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => LibyanTitleBloc(
        fetchLibyanTitles: serviceLocator(),
      ),
    );
}

void _initHome() {
  // Datasource
  serviceLocator.registerFactory<HomeBloc>(
    () => HomeBloc(
      fetchPoets: serviceLocator(),
      getMostStreamed: serviceLocator(),
    ),
  );
}
// void initPurpose(){
//   // Datasource


//   // Repository


//   // Usecases

//   // Bloc
// }

// void _initBlog() {
//   // Datasource
//   serviceLocator
//     ..registerFactory<BlogRemoteDataSource>(
//       () => BlogRemoteDataSourceImpl(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory<BlogLocalDataSource>(
//       () => BlogLocalDataSourceImpl(
//         serviceLocator(),
//       ),
//     )
//     // Repository
//     ..registerFactory<BlogRepository>(
//       () => BlogRepositoryImpl(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     )
//     // Usecases
//     ..registerFactory(
//       () => UploadBlog(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory(
//       () => GetAllBlogs(
//         serviceLocator(),
//       ),
//     )
//     // Bloc
//     ..registerLazySingleton(
//       () => BlogBloc(
//         uploadBlog: serviceLocator(),
//         getAllBlogs: serviceLocator(),
//       ),
//     );
// }

void _initCompetition() {
  // Datasource
  serviceLocator
    ..registerFactory<CompetitionRemoteDataSource>(
      () => CompetitionRemoteDataSourceImpl(client: serviceLocator()),
    )

    // Repository
    ..registerFactory<CompetitionRepository>(
      () => CompetitionRepositoryImpl(remoteDataSource: serviceLocator()),
    )

    // Usecases
    ..registerFactory(
      () => GetCompetitions(serviceLocator()),
    )
    ..registerFactory(
      () => GetCompetitionContestants(serviceLocator()),
    )
    ..registerFactory(
      () => VoteContestant(serviceLocator()),
    )
    ..registerFactory(
      () => UnVoteContestant(serviceLocator()),
    )

    // Bloc
    ..registerLazySingleton(
      () => CompetitionBloc(
        getCompetitions: serviceLocator(),
        getCompetitionContestants: serviceLocator(),
        voteContestant: serviceLocator(),
        unVoteContestant: serviceLocator(),
      ),
    );
}
