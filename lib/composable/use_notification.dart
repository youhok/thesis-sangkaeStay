import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UseNotification {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Initialize notification settings
  Future<void> initialize() async {
    // Request permission for notifications
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  // Get FCM token
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
      rethrow;
    }
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
      rethrow;
    }
  }

  // Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Handling foreground message: ${message.messageId}');

    // Show local notification
    await _showLocalNotification(
      title: message.notification?.title ?? 'New Message',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
    );
  }

  // Handle notification tap when app is in background
  void _handleMessageOpenedApp(RemoteMessage message) {
    print('Message opened app: ${message.messageId}');
    // Handle navigation or other actions based on the message data
    _handleNotificationTap(message.data);
  }

  // Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      details,
      payload: payload,
    );
  }

  // Handle notification tap
  void _handleNotificationTap(Map<String, dynamic> data) {
    // Implement navigation or other actions based on the notification data
    // Example:
    // if (data['type'] == 'property') {
    //   navigateToProperty(data['propertyId']);
    // } else if (data['type'] == 'message') {
    //   navigateToChat(data['chatId']);
    // }
  }
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}

// Create a singleton instance
final useNotification = UseNotification();

/*
Usage Examples:

1. Initialize Notifications:
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     await useNotification.initialize();
     runApp(MyApp());
   }

2. Get FCM Token (for user registration):
   Future<void> registerUser() async {
     final fcmToken = await useNotification.getToken();
     if (fcmToken != null) {
       // Save token to user profile in database
       await userService.updateFcmToken(userId, fcmToken);
     }
   }

3. Subscribe to Topics:
   // Subscribe to property updates
   try {
     await useNotification.subscribeToTopic('property_${propertyId}');
   } catch (e) {
     print('Failed to subscribe to property updates: $e');
   }

   // Subscribe to user notifications
   try {
     await useNotification.subscribeToTopic('user_${userId}');
   } catch (e) {
     print('Failed to subscribe to user notifications: $e');
   }

4. Unsubscribe from Topics:
   // When user leaves a property page
   try {
     await useNotification.unsubscribeFromTopic('property_${propertyId}');
   } catch (e) {
     print('Failed to unsubscribe from property updates: $e');
   }

5. Handle Notification Navigation:
   // In your navigation service or main app widget
   void handleNotificationNavigation(String? payload) {
     if (payload != null) {
       final data = json.decode(payload);
       if (data['type'] == 'property') {
         // Navigate to property details
         Navigator.pushNamed(context, '/property/${data['propertyId']}');
       } else if (data['type'] == 'message') {
         // Navigate to chat
         Navigator.pushNamed(context, '/chat/${data['chatId']}');
       }
     }
   }

6. Send Test Notification (from Firebase Console):
   {
     "notification": {
       "title": "New Property Available",
       "body": "Check out this amazing property in your area!"
     },
     "data": {
       "type": "property",
       "propertyId": "123",
       "click_action": "FLUTTER_NOTIFICATION_CLICK"
     },
     "topic": "property_123"
   }
*/
