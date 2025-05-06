import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/domain/models/voucher.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

abstract class GameRepository {
  Future<Either<AppException, Setting>> getSetting();
  Future<Either<AppException, Voucher>> getVoucher(String code);
  Future<bool> saveSetting({required Setting setting});
  Future<Either<AppException, Setting>> getLocalSetting();
}
