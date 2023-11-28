import 'package:book_keeping/app_root.dart';
import 'package:book_keeping/common/utility/ioc_container.dart';
import 'package:book_keeping/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  IocContainer.setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AppRoot());
}
