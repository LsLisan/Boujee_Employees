import 'package:flutter/material.dart';

import 'core/services/auth_service.dart';
import 'features/my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(MyApp());
}
