import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // Handle foreground messages here

        print('Message received: ${message.notification?.title ?? 'No Title'}');
      },
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Initialize Firebase if not already initialized
    await Firebase.initializeApp();
    // Handle background messages here
    print(
        'Background message received: ${message.notification?.title ?? 'No Title'}');
  }

  // Get FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}
