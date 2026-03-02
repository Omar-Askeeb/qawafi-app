import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Request permission for iOS
  Future<void> requestPermission() async {
    // NotificationSettings settings =
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Initialize FCM
  Future<void> initialize() async {
    await requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages here
      print('Message received: ${message.notification?.title ?? 'No Title'}');
      _showNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Initialize Firebase if not already initialized
    await Firebase.initializeApp();
    // Initialize Awesome Notifications
    AwesomeNotifications().initialize(
      'resource://drawable/ic_notification',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          locked: false,
        )
      ],
    );
    // Handle background messages here
    print(
        'Background message received: ${message.notification?.title ?? 'No Title'}');
    _showNotification(message);
  }

  // Show notification using awesome_notifications
  static Future<void> _showNotification(RemoteMessage message) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        notificationLayout: NotificationLayout.Default,
        icon:
            'resource://drawable/ic_notification', // Reference to your drawable icon
        // Additional properties to ensure the notification appears correctly
        displayOnForeground:
            true, // Display notification when app is in foreground
        displayOnBackground:
            true, // Display notification when app is in background
      ),
    );
  }

  // Get FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Generate unique notification ID
  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }
}
