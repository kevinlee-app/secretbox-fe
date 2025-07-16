import 'package:dio/dio.dart';
import 'package:secretbox/configs/app_configs.dart';

Future<void> loadConfig() async {
    final dio = Dio();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final response = await dio.get('/config.json?v=$timestamp');

    if (response.statusCode == 200) {
      final config = response.data as Map<String, dynamic>;
      final baseUrl = config['BASE_URL'];
      if (baseUrl != null) {
        AppConfigs.baseUrl = baseUrl;
      }
    }
  }