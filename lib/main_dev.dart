import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_mobile_flutter/const/constant.dart';
import 'package:test_mobile_flutter/my_app.dart';
import 'package:test_mobile_flutter/utils/config_flavor.dart';
import 'package:test_mobile_flutter/utils/directory_platform.dart';

void main() async {
  ConfigApps(
    flavor: Flavor.DEVELOPMENT,
    baseUrl: Constant.BASE_URL_DEV,
  );
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    var path = await DirectoryPlatform.findLocalPath();
    Hive..init(path);
    await initializeDateFormatting('id_ID').then((_) {
      runApp(new MyApp());
    });
  }, (error, stack) {});
}
