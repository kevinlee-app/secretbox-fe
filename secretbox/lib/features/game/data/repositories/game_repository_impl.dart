// lib/data/repositories/setting_repository_impl.dart
import 'package:secretbox/features/game/domain/repositories/game_repository.dart';
import 'package:secretbox/features/game/data/datasources/game_remote_data_source.dart';
import 'package:secretbox/services/setting_cache_service/domain/repositories/setting_cache_repository.dart';
import 'package:secretbox/shared/domain/models/core/either.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/domain/models/voucher.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

class GameRepositoryImpl implements GameRepository {
  final GameDataSource dataSource;
  final SettingRepository settingRepository;

  GameRepositoryImpl({
    required this.dataSource,
    required this.settingRepository,
  });

  @override
  Future<Either<AppException, Setting>> getSetting() {
    return dataSource.getSetting();
  }

  @override
  Future<Either<AppException, Voucher>> getVoucher(String code) {
    return dataSource.getVoucher(code);
  }

  @override
  Future<bool> saveSetting({required Setting setting}) async {
    return await settingRepository.saveSetting(setting: setting);
  }
  
  @override
  Future<Either<AppException, Setting>> getLocalSetting() async {
    return await settingRepository.fetchSetting();
  }

  @override
  Future<Either<AppException, bool>> openPrize(String code) async {
    return await dataSource.openPrize(code);
  }
}
