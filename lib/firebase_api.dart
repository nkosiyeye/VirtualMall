

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _firestore = FirebaseFirestore.instance; // Firestore instance

  Future<void> initNotifications(String userId) async {
    // Check current notification settings
    final settings = await _firebaseMessaging.getNotificationSettings();

    // Request permission only if not already granted
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      final newSettings = await _firebaseMessaging.requestPermission();
      if (newSettings.authorizationStatus != AuthorizationStatus.authorized) {
        print('Notification permissions not granted');
        return; // Exit if permission is not granted
      }
    }

    // Get the FCM token
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    // Save the token to Firestore under the specific user
    if (fCMToken != null) {
      await _firestore.collection('Users').doc(userId).update({
        'FcmToken': fCMToken,
      });
    }

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}