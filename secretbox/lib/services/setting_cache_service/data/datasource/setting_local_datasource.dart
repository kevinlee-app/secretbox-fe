import 'dart:convert';
import 'package:secretbox/shared/data/local/storage_service.dart';
import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';
import 'package:secretbox/shared/utils/globals.dart';

abstract class SettingDataSource {
  String get storageKey;

  Future<Either<AppException, Setting>> fetchSetting();
  Future<bool> saveSetting({required Setting setting});
  Future<bool> deleteSetting();
  Future<bool> hasSetting();
}

class SettingLocalDatasource extends SettingDataSource {
  SettingLocalDatasource(this.storageService);

  final StorageService storageService;

  @override
  String get storageKey => SETTING_LOCAL_STORAGE_KEY;

  @override
  Future<Either<AppException, Setting>> fetchSetting() async {
    final data = await storageService.get(storageKey);
    if (data == null) {
      return Left(
        AppException(
          identifier: 'SettingLocalDatasource',
          statusCode: 404,
          message: 'User not found',
        ),
      );
    }
    final userJson = jsonDecode(data.toString());

    return Right(Setting.fromJson(userJson));
  }

  @override
  Future<bool> saveSetting({required Setting setting}) async {
    return await storageService.set(storageKey, jsonEncode(setting.toJson()));
  }

  @override
  Future<bool> deleteSetting() async {
    return await storageService.remove(storageKey);
  }

  @override
  Future<bool> hasSetting() async {
    return await storageService.has(storageKey);
  }
}
