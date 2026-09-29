import 'package:app_template/common/dependency_injection/injection_container.dart';
import 'package:app_template/common/storage/key_value_storage.dart';
import 'package:app_template/project_task.dart';
import 'package:app_template/theme/theme_mode_handler.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  final themeScope = await ThemeScopeWidget.initialize(
    const ProjectTask(),
    sl<KeyValueStorage>(),
  );
  runApp(themeScope);
}
