import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/services/setting_cache_service/data/datasource/setting_local_datasource.dart';
import 'package:secretbox/services/setting_cache_service/data/repositories/setting_repository_impl.dart';
import 'package:secretbox/services/setting_cache_service/domain/repositories/setting_cache_repository.dart';
import 'package:secretbox/shared/data/local/storage_service.dart';
import 'package:secretbox/shared/domain/providers/shared_preferences_storage_service_provider.dart';

final settingDatasourceProvider =
    Provider.family<SettingDataSource, StorageService>(
      (_, networkService) => SettingLocalDatasource(networkService),
    );

final settingLocalRepositoryProvider = Provider<SettingRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  final datasource = ref.watch(settingDatasourceProvider(storageService));

  final repository = SettingRepositoryImpl(datasource);

  return repository;
});
