import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/services/setting_cache_service/domain/providers/setting_cache_provider.dart';
import 'package:secretbox/shared/domain/models/setting.dart';

final currentSettingProvider = FutureProvider<Setting?>((ref) async {
  final repository = ref.watch(settingLocalRepositoryProvider);
  final eitherType = (await repository.fetchSetting());

  return eitherType.fold((l) => null, (r) => r);
});
