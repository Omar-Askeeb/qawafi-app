class EndPoints {
  static const int timeout = 15;
  // static const String baseUrl = 'https://52.157.210.116';
  // static const String baseUrl = 'http://45.8.148.7:5099';
  static const String baseUrl = 'https://qawafi.com.ly:5099';
  static const String webViewbaseUrl = 'https://qawafi.com.ly';

  static const String signUp = '$baseUrl/Customer/register';
  static const String login = '$baseUrl/Customer/login';
  static const String requestOtp = '$baseUrl/Customer/otp';
  static const String resetDeviceId = '$baseUrl/Customer/reset-device-id';

  static const String getResetPasswordToken =
      '$baseUrl/Customer/generate-reset-password-token';
  static const String resetPassword = '$baseUrl/Customer/reset-password';

  static const String fetchPurposeAll =
      '$baseUrl/Purpose?pageNumber=1&pageSize=2147483647';

  static const String popularProverbs =
      '$baseUrl/PopularProverbs?pageNumber=1&pageSize=200&alphabet={alphabet}';
  static const String Proverbstory = '$baseUrl/ProverbStory';
  static const String CellerTones = '$baseUrl/CallerTones?categoryId={Id}';
  static const String CellerTonesCategoury =
      '$baseUrl/CallerTonesCategory?alphabet={alphabet}&gender={gender}';
  static const String ProverbstoryFavorite =
      '$baseUrl/ProverbStory/add-to-favorite';
  static const String ProverbstoryUnFavorite =
      '$baseUrl/ProverbStory/remove-from-favorite';

  static const String getMelodies =
      '$baseUrl/Melodies?pageNumber=1&pageSize=2147483647';
  static const String getWordsMeaning = '$baseUrl/WordsMeaning';
  static const String poemById = '$baseUrl/Poem/{poemId}';
  static const String poemMostStreamed =
      '$baseUrl/Poem/most-streamed?pageSize=5';
  static const String poemNewest = '$baseUrl/Poem/newest?pageSize=5';

  static const String followPoet = '$baseUrl/Poet/follow';
  static const String unFollowPoet = '$baseUrl/Poet/unfollow';

  static const String fetchPoets = '$baseUrl/Poet';
  static const String fetchPoet = '$baseUrl/Poet/';
  static const String poemAddFavorite = '$baseUrl/Poem/add-to-favorite';
  static const String poemRemoveFavorite = '$baseUrl/Poem/remove-from-favorite';

  static const String fetchQuatrainsCategory = '$baseUrl/QuatrainsCategory';
  static const String fetchQuatrains = '$baseUrl/Quatrains';
  static const String quatrainsAdd2Favorite =
      '$baseUrl/Quatrains/add-to-favorite';
  static const String quatrainsRemoveFromFavorite =
      '$baseUrl/Quatrains/remove-from-favorite';

  static const String advertisement =
      '$baseUrl/Advertisement?pageNumber=1&pageSize=2147483647';

  static const String reels = '$baseUrl/Reels?pageNumber=1&pageSize=2147483647';
  static const String subscriptionPeriod =
      '$baseUrl/SubscriptionPeriod?pageNumber=1&pageSize=2147483647';
  static const String subscriptionCost =
      '$baseUrl/SubscriptionCost?pageNumber=1&pageSize=2147483647'; //&subscriptionPeriodId=1&paymentMethodId=1';

  static const String paymentMethod =
      '$baseUrl/PaymentMethod?pageNumber=1&pageSize=2147483647';
  static const String customerSubscribe =
      '$baseUrl/Customer/{userId}/Subscribe';
  static const String customerCancelSubscription =
      '$baseUrl/Customer/{userId}/cancel-subscription';
  static const String customerChargeWallet =
      '$baseUrl/Customer/{userId}/charge-wallet';
  static const String customerRefreshToken = '$baseUrl/Customer/refresh-token';
  static const String StoryProverbAdd2Favorite =
      '$baseUrl/ProverbStory/add-to-favorite';
  static const String storyProverbRemoveFromFavorite =
      '$baseUrl/ProverbStory/remove-from-favorite';
  static const String support = '$baseUrl/Support';

  static const String notificationToken = '$baseUrl/Customer/NotificationToken';

  static const String favoriteQuatrains =
      '$baseUrl/Customer/{userId}/quatrains/favorite-quatrains?pageNumber=1&pageSize=2147483647';
  static const String favoriteProverbStory =
      '$baseUrl/Customer/{userId}/proverb-story/favorite-proverb-story?pageNumber=1&pageSize=2147483647';

  static const String favoritePoem =
      '$baseUrl/Customer/{userId}/poem/favorite-poem?pageNumber=1&pageSize=2147483647';
  static const String favoritepokenProverbs =
      '$baseUrl/Customer/{userId}/spoken-proverbs/favorite-spoken-proverb?pageNumber=1&pageSize=2147483647';

  static const String mySubscription =
      '$baseUrl/Customer/{userId}/subscription';

  static const String updateUserInfo =
      '$baseUrl/Customer/{userId}/update-profile';

  static const String changePassword = '$baseUrl/Customer/change-password';
  static const String walletTransactions =
      '$baseUrl/Customer/{userId}/charge-wallet?pageNumber=1&pageSize=2147483647';
  static const String spokenProverbsCategory =
      '$baseUrl/SpokenProverbsCategory?pageNumber=1&pageSize=2147483647';
  static const String spokenProverbs =
      '$baseUrl/SpokenProverbs?pageNumber=1&pageSize=2147483647&categoryId={categoryId}';
  static const String libyanTitles =
      '$baseUrl/LibyanTitles?pageNumber={pageNumber}&pageSize={pageSize}';
  static const String libyanTitlesId = '$baseUrl/LibyanTitles/{id}';

  static String poem(
      {int? pageNumber,
      int? pageSize,
      String? title,
      String? beginning,
      String? keywords,
      String? purpose,
      String? poemCategory,
      String? melodiesName,
      String? poetId}) {
    final Map<String, String> queryParams = {};

    if (pageNumber != null) queryParams['pageNumber'] = pageNumber.toString();
    if (pageSize != null) queryParams['pageSize'] = pageSize.toString();
    if (title != null) queryParams['title'] = title;
    if (beginning != null) queryParams['beginning'] = beginning;
    if (keywords != null) queryParams['Keywords'] = keywords;
    if (purpose != null) queryParams['Purpose'] = purpose;
    if (poemCategory != null) queryParams['poemCategory'] = poemCategory;
    if (melodiesName != null) queryParams['melodiesName'] = melodiesName;
    if (poetId != null) queryParams['poetId'] = poetId;

    final queryString = Uri(queryParameters: queryParams).query;
    return '$baseUrl/Poem?$queryString';
  }

  static const String competition = 'https://qawafi.com.ly:5099/Competition';
  static String getCompetitionContestants(String id) =>
      '$competition/$id/contestants?pageNumber=1&pageSize=2147483647&contestantsOrder=ByVotesDescending';
  
  static const String voteContestant = 'https://qawafi.com.ly:5099/Contestant/vote';
  static const String unVoteContestant = 'https://qawafi.com.ly:5099/Contestant/UnVote';
}
