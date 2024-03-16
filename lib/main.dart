import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:al_khabeer/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api_manager/api_service.dart';
import 'core/app/app_widget.dart';
import 'core/app/bloc/loading_cubit.dart';
import 'core/app/insert_firebase_token_cubit.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/injection/injection_container.dart';
import 'core/util/shared_preferences.dart';
import 'features/notifications/bloc/notification_count_cubit/notification_count_cubit.dart';

import 'firebase_options.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Note.initialize();
  await di.init();
  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  try {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  } on Exception {
    loggerObject.e('error FCM ios ');
  }
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    AppSharedPreference.cashFireToken(fcmToken);
    sl<InsertFirebaseTokenCubit>().insertFirebaseToken();
  }).onError((err) {
    // Error getting token.
  });

  sl<InsertFirebaseTokenCubit>().insertFirebaseToken();

  try {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  } on Exception {
    loggerObject.e('error FCM ios ');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    String title = '';
    String body = '';

    if (notification != null) {
      title = notification.title ?? '';
      body = notification.body ?? '';
    } else {
      title = message.data['title'] ?? '';
      body = message.data['body'] ?? '';
    }

    showNotification(title, body);
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

Future<String> getFireToken() async {
  var cashedToken = AppSharedPreference.getFireToken();

  final messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();

  cashedToken = token ?? '';
  if (token != null) AppSharedPreference.cashFireToken(token);

  loggerObject.d(cashedToken);

  return cashedToken;
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();

  final notification = message.notification;

  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  String title = '';
  String body = '';

  if (notification != null) {
    title = notification.title ?? '';
    body = notification.body ?? '';
  } else {
    title = message.data['title'] ?? '';
    body = message.data['body'] ?? '';
  }

  showNotification(title, body);
}

void showNotification(String title, String body) {
  if (!AppSharedPreference.getActiveNotification()) return;
  Note.showBigTextNotification(title: title, body: body);
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
