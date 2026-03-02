import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qawafi_app/features/customer/data/models/subscription_model.dart';

import '../../features/customer/domain/entites/subscription.dart';
import '../common/entities/user.dart';
import '../enums/local_keys.dart';
import '../utils/parse_bool.dart';

abstract class LocalStorage {
  Future<String> get accessToken;
  Future<String> get refreshToken;
  Future<String> get userData;
  Future<User?> get user;
  Future<bool> get isFirstTime;
  Future<Subscription?> get mySubscription;
  Future<void> storeAccessToken(String value);
  Future<void> storeRefreshToken(String value);
  Future<void> storeUserData(String value);
  Future<void> storeUser(String value);
  Future<void> storeIsFirstTime(String value);
  Future<void> storeMySubscription(String value);
}

class LocalStorageImpl implements LocalStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
          encryptedSharedPreferences: true, resetOnError: false));
  LocalStorageImpl();

  @override
  Future<String> get accessToken async =>
      await secureStorage.read(
          key: LocalStorageKeys.accessToken.toEncryptedKey) ??
      '';

  @override
  Future<String> get userData async =>
      await secureStorage.read(key: LocalStorageKeys.userData.toEncryptedKey) ??
      '';

  @override
  Future<String> get refreshToken async =>
      await secureStorage.read(
          key: LocalStorageKeys.refreshToken.toEncryptedKey) ??
      '';
  @override
  Future<bool> get isFirstTime async => parseStringToBool(
      await secureStorage.read(key: LocalStorageKeys.firstTime.toEncryptedKey));

  @override
  Future<void> storeAccessToken(String value) => secureStorage.write(
        key: LocalStorageKeys.accessToken.toEncryptedKey,
        value: 'Bearer ' + value.toString(),
      );

  @override
  Future<void> storeRefreshToken(String value) async {
    log(value);
    secureStorage.write(
      key: LocalStorageKeys.refreshToken.toEncryptedKey,
      value: value.toString(),
    );
  }

  @override
  Future<void> storeUser(String value) async {
    log(value);
    secureStorage.write(
      key: LocalStorageKeys.User.toEncryptedKey,
      value: value.toString(),
    );
  }

  @override
  Future<void> storeUserData(String value) => secureStorage.write(
        key: LocalStorageKeys.userData.toEncryptedKey,
        value: value.toString(),
      );

  @override
  Future<void> storeIsFirstTime(String value) async {
    secureStorage.write(
      key: LocalStorageKeys.firstTime.toEncryptedKey,
      value: value.toString(),
    );
  }

  @override
  // TODO: implement userUser
  Future<User?> get user async {
    String? data =
        await secureStorage.read(key: LocalStorageKeys.User.toEncryptedKey);
    return (data != null && data.trim().isNotEmpty)
        ? User.fromJson(jsonDecode(data))
        : null;
  }

  @override
  // TODO: implement mySubscription
  Future<Subscription?> get mySubscription async {
    String? data = await secureStorage.read(
        key: LocalStorageKeys.mySubscription.toEncryptedKey);
    return (data != null && data.trim().isNotEmpty)
        ? SubscriptionModel.fromJson(jsonDecode(data))
        : null;
  }

  @override
  Future<void> storeMySubscription(String value) async {
    log(value);
    secureStorage.write(
      key: LocalStorageKeys.mySubscription.toEncryptedKey,
      value: value.toString(),
    );
  }
}
