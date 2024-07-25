import 'package:catatan_sehat_ku/firebase_options.dart';
import 'package:catatan_sehat_ku/src/views/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.storage.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  await ScreenUtil.ensureScreenSize();

  runApp(const Root());
}
