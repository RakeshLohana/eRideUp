import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await Firebase.initializeApp();
    await _initializeLocalNotifications();
    await _requestPermissions();
    await _configureFirebaseMessaging();
  }

  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    // Create notification channel for Android (required for newer versions)
    await _createNotificationChannel();
  }

  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _localNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(channel);
    }
  }

  static Future<void> _requestPermissions() async {
    // Request Firebase Messaging permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    print('Notification permission status: ${settings.authorizationStatus}');

    // For Android 13+ (API level 33+) - Updated permission handling
    if (Platform.isAndroid) {
      final PermissionStatus status = await Permission.notification.status;
      if (status.isDenied) {
        await Permission.notification.request();
      }

      // Also request exact alarm permission for scheduling (if needed)
      if (Platform.isAndroid) {
        final PermissionStatus alarmStatus =
            await Permission.scheduleExactAlarm.status;
        if (alarmStatus.isDenied) {
          await Permission.scheduleExactAlarm.request();
        }
      }
    }

    // For iOS, request local notification permissions separately
    if (Platform.isIOS) {
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static Future<void> _configureFirebaseMessaging() async {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received foreground message: ${message.messageId}');
      _showNotification(message);
    });

    // Handle notification opened app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened app: ${message.messageId}');
      _handleNotificationClick(message);
    });

    // Handle notification when app is terminated
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('App opened from terminated state: ${initialMessage.messageId}');
      _handleNotificationClick(initialMessage);
    }

    // Set foreground notification presentation options for iOS
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
      // Additional styling options for newer versions
      styleInformation: DefaultStyleInformation(true, true),
      visibility: NotificationVisibility.public,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.active,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  static void _onNotificationResponse(
      NotificationResponse notificationResponse) {
    print('Notification clicked: ${notificationResponse.payload}');
    _handleNotificationClick(null, payload: notificationResponse.payload);
  }

  static void _handleNotificationClick(RemoteMessage? message,
      {String? payload}) {
    print('Handle notification click');

    // Extract data for navigation
    Map<String, dynamic>? data = message?.data;

    // Example navigation logic based on notification data
    if (data != null) {
      String? screen = data['screen'];
      String? userId = data['user_id'];

      switch (screen) {
        case 'profile':
          // Navigate to profile screen
          print('Navigate to profile for user: $userId');
          break;
        case 'chat':
          // Navigate to chat screen
          print('Navigate to chat');
          break;
        case 'notifications':
          // Navigate to notifications screen
          print('Navigate to notifications');
          break;
        default:
          // Navigate to home or default screen
          print('Navigate to home');
      }
    }

    // You can also use a navigation service or global navigator key here
    // Example: Get.toNamed('/profile', arguments: {'userId': userId});
  }

  static Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print('FCM Token refreshed: $newToken');
        // Send the new token to your server here
        _sendTokenToServer(newToken);
      });

      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  static void _sendTokenToServer(String token) {
    // Implement your server API call here to update the token
    print('Sending token to server: $token');
    // Example: ApiService.updateFCMToken(token);
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Successfully subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic $topic: $e');
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Successfully unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic $topic: $e');
    }
  }

  // Method to handle different notification types
  static Future<void> showCustomNotification({
    required String title,
    required String body,
    String? payload,
    String? imageUrl,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'custom_channel',
      'Custom Notifications',
      channelDescription: 'Custom notifications from the app',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Method to check notification permissions
  static Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      return await Permission.notification.isGranted;
    } else if (Platform.isIOS) {
      final settings = await _firebaseMessaging.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    }
    return false;
  }

  // Method to delete token (useful for logout)
  static Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      print('FCM Token deleted successfully');
    } catch (e) {
      print('Error deleting FCM token: $e');
    }
  }
}

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
}

// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

// class FirebaseService {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
//   static Future<void> initialize() async {
//     await Firebase.initializeApp();
//     await _initializeLocalNotifications();
//     await _requestPermissions();
//     await _configureFirebaseMessaging();
//   }
  
//   static Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings androidSettings = 
//         AndroidInitializationSettings('@mipmap/ic_launcher');
    
//     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
    
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
    
//     await _localNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onNotificationResponse,
//     );
//   }
  
//   static Future<void> _requestPermissions() async {
//     // Request notification permissions
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//     );
    
//     print('Notification permission status: ${settings.authorizationStatus}');
    
//     // For Android 13+ (API level 33+)
//     if (Platform.isAndroid) {
//       await Permission.notification.isDenied.then((value) {
//         if (value) {
//           Permission.notification.request();
//         }
//       });
//     }
//   }
  
//   static Future<void> _configureFirebaseMessaging() async {
//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received foreground message: ${message.messageId}');
//       _showNotification(message);
//     });
    
//     // Handle notification opened app
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Notification opened app: ${message.messageId}');
//       _handleNotificationClick(message);
//     });
    
//     // Handle notification when app is terminated
//     RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null) {
//       print('App opened from terminated state: ${initialMessage.messageId}');
//       _handleNotificationClick(initialMessage);
//     }
//   }
  
//   static Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = 
//         AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       channelDescription: 'This channel is used for important notifications.',
//       importance: Importance.high,
//       priority: Priority.high,
//       showWhen: true,
//       icon: '@mipmap/ic_launcher',
//     );
    
//     const DarwinNotificationDetails iosPlatformChannelSpecifics = 
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
    
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );
    
//     await _localNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? 'No Title',
//       message.notification?.body ?? 'No Body',
//       platformChannelSpecifics,
//       payload: message.data.toString(),
//     );
//   }
  
//   static void _onNotificationResponse(NotificationResponse notificationResponse) {
//     print('Notification clicked: ${notificationResponse.payload}');
//     // Handle notification click
//     _handleNotificationClick(null, payload: notificationResponse.payload);
//   }
  
//   static void _handleNotificationClick(RemoteMessage? message, {String? payload}) {
//     // Navigate to specific screen based on notification data
//     print('Handle notification click');
//     // Add your navigation logic here
//   }
  
//   static Future<String?> getToken() async {
//     try {
//       String? token = await _firebaseMessaging.getToken();
//       print('FCM Token: $token');
//       return token;
//     } catch (e) {
//       print('Error getting FCM token: $e');
//       return null;
//     }
//   }
  
//   static Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//     print('Subscribed to topic: $topic');
//   }
  
//   static Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//     print('Unsubscribed from topic: $topic');
//   }
// }

// // Top-level function for background message handling
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling background message: ${message.messageId}');
//   // You can show notification here too if needed
// }