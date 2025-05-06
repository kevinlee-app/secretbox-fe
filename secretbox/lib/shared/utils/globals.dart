import 'dart:io' if (kIsWeb) 'dart:html';

import 'package:flutter/foundation.dart';

final kTestMode =
    kIsWeb
        ? (Uri.base.queryParameters['testMode'] == 'true')
        : Platform.environment.containsKey('FLUTTER_TEST');

// ignore: constant_identifier_names
const int PRODUCTS_PER_PAGE = 20;
const String SETTING_LOCAL_STORAGE_KEY = 'user';
const String APP_THEME_STORAGE_KEY = 'AppTheme';
