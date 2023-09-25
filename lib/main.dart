import 'dart:io';

import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app/app_widget.dart';
import 'core/app/bloc/loading_cubit.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';
import 'features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';

//adb shell setprop debug.firebase.analytics.app com.slf.al_khabeer
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // try {
  //   FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // } on Exception {
  //   loggerObject.e('error FCM ios ');
  // }
  //
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Note.initialize();

  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColorManager.mainColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoadingCubit>()),
        BlocProvider(create: (_) => di.sl<NotificationCountCubit>()),
      ],
      child: const MyApp(),
    ),
  );

  // sl<InsertFirebaseTokenCubit>().insertFirebaseToken();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

class Note {
  static Future initialize() async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    // var vibrationPattern = Int64List(2);
    // vibrationPattern[0] = 1000;
    // vibrationPattern[1] = 1000;

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Ali Gabory',
      'Gabory App',
      playSound: true,
      // enableVibration: true,
      // sound: RawResourceAndroidNotificationSound('sound'),
      // vibrationPattern: vibrationPattern,
      importance: Importance.defaultImportance,
      priority: Priority.high,
    );

    var not = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
        (DateTime.now().millisecondsSinceEpoch ~/ 1000), title, body, not);
  }
}
