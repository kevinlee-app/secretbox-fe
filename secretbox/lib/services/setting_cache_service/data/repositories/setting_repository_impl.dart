import 'package:secretbox/services/setting_cache_service/data/datasource/setting_local_datasource.dart';
import 'package:secretbox/services/setting_cache_service/domain/repositories/setting_cache_repository.dart';
import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

class SettingRepositoryImpl extends SettingRepository {
  SettingRepositoryImpl(this.dataSource);

  final SettingDataSource dataSource;

  @override
  Future<bool> deleteSetting() {
    return dataSource.deleteSetting();
  }

  @override
  Future<Either<AppException, Setting>> fetchSetting() {
    return dataSource.fetchSetting();
  }

  @override
  Future<bool> saveSetting({required Setting setting}) {
    return dataSource.saveSetting(setting: setting);
  }

  @override
  Future<bool> hasSetting() {
    return dataSource.hasSetting();
  }
}
