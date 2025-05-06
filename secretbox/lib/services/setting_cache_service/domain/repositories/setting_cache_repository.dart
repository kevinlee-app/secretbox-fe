import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

abstract class SettingRepository {
  Future<Either<AppException, Setting>> fetchSetting();
  Future<bool> saveSetting({required Setting setting});
  Future<bool> deleteSetting();
  Future<bool> hasSetting();
}
