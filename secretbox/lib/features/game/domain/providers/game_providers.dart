// lib/core/providers/setting_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/features/game/data/datasources/game_remote_data_source.dart';
import 'package:secretbox/features/game/data/repositories/game_repository_impl.dart';
import 'package:secretbox/features/game/domain/repositories/game_repository.dart';
import 'package:secretbox/services/setting_cache_service/domain/providers/setting_cache_provider.dart';
import 'package:secretbox/services/setting_cache_service/domain/repositories/setting_cache_repository.dart';
import 'package:secretbox/shared/data/remote/network_service.dart';
import 'package:secretbox/shared/domain/providers/dio_network_service_provider.dart';

final gameDataSourceProvider = Provider.family<GameDataSource, NetworkService>(
  (_, networkService) => GameRemoteDataSource(networkService),
);

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final NetworkService networkService = ref.watch(networkServiceProvider);
  final GameDataSource dataSource = ref.watch(
    gameDataSourceProvider(networkService),
  );
  final SettingRepository settingRepository = ref.watch(
    settingLocalRepositoryProvider,
  );
  return GameRepositoryImpl(
    dataSource: dataSource,
    settingRepository: settingRepository,
  );
});
